/// <summary>
/// component: Data Structures
/// </summary>
codeunit 50014 "API MD Structure JSON Impl." implements "API MD IStructure"
{
    var
        hRecordRef: Codeunit "API MD Record Ref. Helper";
        sCommon: Codeunit "API MD Common Service";
        sStructure: Codeunit "API MD Structure Service";
        sStructureMap: Codeunit "API MD Structure Map Service";
        sStructureTableSetup: Codeunit "API MD Struct Tbl Set. Service";
        sStructureTableRelation: Codeunit "API MD Struct Tbl Rel Service";
        GlobalTempBlob: Codeunit "Temp Blob";
        GlobalInStream: InStream;
        GlobalOutStream: OutStream;
        GlobalJsonObject: JsonObject;

    /// <summary>
    /// ExportDataAsText.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="DataAsText">VAR Text.</param>
    procedure ExportDataAsText(StructureCode: Code[30]; var RecRef: RecordRef; var DataAsText: Text)
    var
        DataAsJson: JsonObject;
    begin
        DataAsJson := CreateJsonByStructure(StructureCode, RecRef);
        DataAsJson.WriteTo(DataAsText);
    end;
    /// <summary>
    /// ExportDataAsFile.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="FileName">Text.</param>
    procedure ExportDataAsFile(StructureCode: Code[30]; var RecRef: RecordRef; FileName: Text)
    begin
        CreateJsonByStructure(StructureCode, RecRef);
    end;
    /// <summary>
    /// ExportDataAsBlob.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="TempBlob">VAR Codeunit "Temp Blob".</param>
    procedure ExportDataAsBlob(StructureCode: Code[30]; var RecRef: RecordRef; var TempBlob: Codeunit "Temp Blob")
    begin
    end;
    /// <summary>
    /// ExportDataAsStream.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="IStream">VAR InStream.</param>
    procedure ExportDataAsStream(StructureCode: Code[30]; var RecRef: RecordRef; var IStream: InStream)
    begin
    end;

    local procedure CreateJsonByStructure(StructureCode: Code[30]; var BaseRecRef: RecordRef) JsonContent: JsonObject
    var
        StructureMapBuffer: Record "API MD Data Structure Map" temporary;
        StructureTableSetup: Record "API MD Structure Table Setup";
        CurrentTableNo: Integer;
        Index: Integer;
        JObject: JsonObject;
        JArray: JsonArray;
    begin
        sCommon.TestEmpty(StructureCode, 'Structure Code parameter is empty!');
        if BaseRecRef.IsEmpty() then
            exit;

        sStructure.SetByPK(StructureCode);
        if not sStructure.IsActive() then
            Error('Structure %1 is not active.', StructureCode);

        sStructureTableSetup.SetStructureCode(StructureCode);
        if not sStructureTableSetup.SetByBaseTable() then
            Error('For structure %1 not selected base table');

        if sStructureTableSetup.GetTableNo(true) <> BaseRecRef.Number then
            Error('Table %1 is not base for structure code %2', BaseRecRef.Caption, StructureCode);

        BaseRecRef.FindSet(false);
        repeat
            JObject := CreateJson(StructureCode, BaseRecRef);
            JArray.Add(JObject);
        until BaseRecRef.Next() = 0;

        JsonContent.Add('Data', JArray);
    end;

    local procedure CreateJson(StructureCode: Code[30]; RecRef: RecordRef) MainJsonObj: JsonObject
    var
        StructureMap: Record "API MD Data Structure Map";
    begin
        sStructureMap.SetStructureCode(StructureCode);
        sStructureMap.SetParentNodeNoFilter(0);
        sStructureMap.SetActiveStatusFilter();
        if not sStructureMap.GetSetOf(StructureMap) then
            exit; // TODO: Except Error Invalid Settings Structure

        MainJsonObj := GetJObject(StructureMap, RecRef);

    end;

    /// <summary>
    /// GetJObject.
    /// </summary>
    /// <param name="StructureMap">VAR Record "JB Structure Map".</param>
    /// <param name="RelationRecRef">RecordRef.</param>
    /// <returns>Return variable RetvalJObject of type JsonObject.</returns>
    procedure GetJObject(var StructureMap: Record "API MD Data Structure Map"; RelationRecRef: RecordRef) RetvalJObject: JsonObject
    var
        JObject: JsonObject;
        LocalStructureMap: Record "API MD Data Structure Map";
        JArray: JsonArray;
        SourceRecRef: RecordRef;
    begin
        if StructureMap.FindSet(true) then
            repeat
                sStructureMap.SetStructureCode(StructureMap."Structure Code");
                sStructureMap.SetParentNodeNoFilter(StructureMap."Node No.");
                sStructureMap.SetActiveStatusFilter();
                if sStructureMap.GetSetOf(LocalStructureMap) then begin

                    sStructureTableSetup.SetByPK(StructureMap."Structure Code", StructureMap."Table Code");
                    if sStructureTableSetup.GetRecRefByRelationRecordId(RelationRecRef.RecordId, SourceRecRef) then begin
                        SourceRecRef.FindSet(false);
                        repeat
                            JObject := GetJObject(LocalStructureMap, SourceRecRef);
                            JArray.Add(JObject);
                        until SourceRecRef.Next() = 0;
                        RetvalJObject.Add(StructureMap."Node Name", JArray);
                    end else begin
                        JObject := GetJObject(LocalStructureMap, SourceRecRef);
                        if JObject.Values.Count > 0 then
                            RetvalJObject.Add(StructureMap."Node Name", JObject);
                    end;
                end else begin
                    if RelationRecRef.Number > 0 then
                        if StructureMap."Field No." <> 0 then
                            StructureMap.Value := Format(RelationRecRef.Field(StructureMap."Field No.").Value);

                    AddValueToJObjectByDataType(StructureMap, RetvalJObject);
                end;
            until StructureMap.Next() = 0;

    end;

    local procedure AddValueToJObjectByDataType(StructureMap: Record "API MD Data Structure Map"; var JObject: JsonObject)
    var
        DataType: Enum "API MD Data Type";
        JValue: JsonValue;
        ValueBool: Boolean;
        ValueInt: Integer;
        ValueBigInt: BigInteger;
        AddedValue: Boolean;
        ErrorNodeEmpty: Label 'Node %1 from Structure %2 not must be empy!';
    begin
        JValue.SetValue(StructureMap."Value");
        case StructureMap."Data Type" of
            DataType::Code:
                if JValue.AsCode() <> '' then
                    AddedValue := JObject.Add(StructureMap."Node Name", JValue.AsCode());
            DataType::Biginteger:
                if JValue.AsBigInteger() > 0 then
                    AddedValue := JObject.Add(StructureMap."Node Name", JValue.AsBigInteger());
            DataType::Integer:
                if JValue.AsInteger() > 0 then
                    AddedValue := JObject.Add(StructureMap."Node Name", JValue.AsInteger());
            DataType::Decimal:
                if JValue.AsDecimal() > 0 then
                    AddedValue := JObject.Add(StructureMap."Node Name", JValue.AsDecimal());
            DataType::Boolean:
                if JValue.AsBoolean() then
                    AddedValue := JObject.Add(StructureMap."Node Name", JValue.AsBoolean());
            else
                if JValue.AsText() <> '' then
                    AddedValue := JObject.Add(StructureMap."Node Name", JValue.AsText());

                if not AddedValue then
                    if StructureMap.Mondatory then
                        Error(ErrorNodeEmpty, StructureMap."Node Name", StructureMap."Structure Code");
        end;
    end;
}
