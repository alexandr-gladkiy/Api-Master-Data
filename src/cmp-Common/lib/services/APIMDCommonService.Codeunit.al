/// <summary>
/// component: Common
/// </summary>
codeunit 50002 "API MD Common Service"
{
    var
        ErrorVariantNotIsRecord: Label 'Rec not is Record';
    /// <summary>
    /// TestEmpty.
    /// </summary>
    /// <param name="VarValue">Variant.</param>
    /// <param name="ErrorMessage">Text.</param>
    procedure TestEmpty(VarValue: Variant; ErrorMessage: Text)
    var
        TextValue: Text;
        GuidValue: Guid;
        IntValue: Integer;
        BigIntValue: BigInteger;
        DecimalValue: Decimal;
        ErrorParameterIsEmpty: Label '%1 parameter is empty';
    begin
        if VarValue.IsCode or VarValue.IsText then begin
            Evaluate(TextValue, VarValue);
            if TextValue = '' then
                Error(ErrorParameterIsEmpty, ErrorMessage);
        end;
        if VarValue.IsGuid then begin
            Evaluate(GuidValue, VarValue);
            if IsNullGuid(GuidValue) then
                Error(ErrorParameterIsEmpty, ErrorMessage);
        end;
        if VarValue.IsInteger then begin
            IntValue := VarValue;
            if IntValue = 0 then
                Error(ErrorParameterIsEmpty, ErrorMessage);
        end;
        if VarValue.IsDecimal then begin
            DecimalValue := VarValue;
            if DecimalValue = 0 then
                Error(ErrorParameterIsEmpty, ErrorMessage);
        end;
        if VarValue.IsBigInteger then begin
            BigIntValue := VarValue;
            if BigIntValue = 0 then
                Error(ErrorParameterIsEmpty, ErrorMessage);
        end;
    end;
    /// <summary>
    /// TestTemporaryRecord.
    /// </summary>
    /// <param name="Rec">Variant.</param>
    /// <param name="RecVarName">Text.</param>
    procedure TestTemporaryRecord(Rec: Variant; RecVarName: Text)
    var
        RecRef: RecordRef;
        ErrorRecordMustBeTemporary: Label 'Record %1 must be temporary.';
    begin
        if not Rec.IsRecord then
            Error(ErrorVariantNotIsRecord);
        RecRef.GetTable(Rec);
        if not RecRef.IsTemporary() then
            Error(ErrorRecordMustBeTemporary, RecVarName)
    end;
    /// <summary>
    /// LookupTableID.
    /// </summary>
    /// <param name="NewObjectID">VAR Integer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure LookupTableID(var NewObjectID: Integer): Boolean
    var
        AllObjWithCaption: Record AllObjWithCaption;
        Objects: Page Objects;
    begin
        AllObjWithCaption.FilterGroup(2);
        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::"Table");
        AllObjWithCaption.FilterGroup(0);
        Objects.SetRecord(AllObjWithCaption);
        Objects.SetTableView(AllObjWithCaption);
        Objects.LookupMode := true;
        if Objects.RunModal() = Action::LookupOK then begin
            Objects.GetRecord(AllObjWithCaption);
            NewObjectID := AllObjWithCaption."Object ID";
            exit(true);
        end;
    end;
    /// <summary>
    /// LookupFieldNo.
    /// </summary>
    /// <param name="TableNo">Integer.</param>
    /// <param name="FieldNo">VAR Integer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure LookupFieldNo(TableNo: Integer; var FieldNo: Integer): Boolean
    var
        RecField: Record Field;
        FieldSelection: Codeunit "Field Selection";
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        RecField.Reset();
        RecField.SetRange(TableNo, TableNo);
        if FieldSelection.Open(RecField) then begin
            FieldNo := RecField."No.";
            exit(true);
        end;
    end;
}
