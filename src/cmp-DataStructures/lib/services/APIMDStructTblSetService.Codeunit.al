/// <summary>
/// component: Data Structure
/// </summary>
codeunit 50010 "API MD Struct Tbl Set. Service"
{
    var
        sCommon: Codeunit "API MD Common Service";
        sStructureTableRelation: Codeunit "API MD Struct Tbl Rel Service";
        GlobalStructureTableSetup: Record "API MD Structure Table Setup";
        HasStructureTableSetup: Boolean;
        ErrorStructureTableIsNotSetup: Label 'Structure is not initialized. Use SetStructureTableSetup function first.';

        GlobalStructureCode: Code[30];
        IsSetStructureCode: Boolean;
        GlobalBaseTableFilter: Boolean;
        IsSetBaseTableFilter: Boolean;
        ErrorStructureCodeIsNotSetup: Label 'Structure Code is not initialized. Use SetStructureCode function first.';

    /// <summary>
    /// Clear.
    /// </summary>
    procedure Clear()
    begin
        ClearAll();
    end;
    /// <summary>
    /// SetByPK.
    /// </summary>
    /// <param name="StructuteCode">Code[30].</param>
    /// <param name="TableCode">Code[30].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetByPK(StructuteCode: Code[30]; TableCode: Code[30]): Boolean
    begin
        HasStructureTableSetup := GlobalStructureTableSetup.Get(StructuteCode, TableCode);
        exit(HasStructureTableSetup);
    end;
    /// <summary>
    /// SetByBaseTable.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetByBaseTable(): Boolean
    begin
        if not IsSetStructureCode then
            Error(ErrorStructureCodeIsNotSetup);

        GlobalStructureTableSetup.Reset();
        GlobalStructureTableSetup.SetCurrentKey("Structure Code", "Base Table");
        GlobalStructureTableSetup.SetRange("Structure Code", GlobalStructureCode);
        GlobalStructureTableSetup.SetRange("Base Table", true);
        HasStructureTableSetup := GlobalStructureTableSetup.FindFirst();
        exit(HasStructureTableSetup);
    end;
    /// <summary>
    /// SetFirst.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetFirst(): Boolean
    begin
        ApplyFilters();
        HasStructureTableSetup := GlobalStructureTableSetup.FindFirst();
        exit(HasStructureTableSetup);
    end;
    /// <summary>
    /// SetStructureCode.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    procedure SetStructureCode(StructureCode: Code[30])
    begin
        GlobalStructureCode := StructureCode;
        IsSetStructureCode := true;
    end;
    /// <summary>
    /// SetBaseTableFilter.
    /// </summary>
    /// <param name="IsBaseTable">Boolean.</param>
    procedure SetBaseTableFilter(IsBaseTable: Boolean)
    begin
        GlobalBaseTableFilter := IsBaseTable;
        IsSetBaseTableFilter := true;
    end;

    local procedure ApplyFilters()
    begin
        GlobalStructureTableSetup.Reset();
        GlobalStructureTableSetup.SetCurrentKey("Structure Code", "Base Table");
        if IsSetStructureCode then
            GlobalStructureTableSetup.SetRange("Structure Code", GlobalStructureCode);
        if IsSetBaseTableFilter then
            GlobalStructureTableSetup.SetRange("Base Table", GlobalBaseTableFilter);
    end;
    /// <summary>
    /// GetTableNo.
    /// </summary>
    /// <param name="DoTestField">Boolean.</param>
    /// <returns>Return value of type Integer.</returns>
    procedure GetTableNo(DoTestField: Boolean): Integer
    begin
        if not HasStructureTableSetup then
            Error(ErrorStructureTableIsNotSetup);

        if DoTestField then
            GlobalStructureTableSetup.TestField("Table No.");
        exit(GlobalStructureTableSetup."Table No.");
    end;
    /// <summary>
    /// GetTableCode.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetTableCode(): Code[30]
    begin
        if not HasStructureTableSetup then
            Error(ErrorStructureTableIsNotSetup);

        exit(GlobalStructureTableSetup."Table Code");
    end;
    /// <summary>
    /// InitBuffer.
    /// </summary>
    /// <param name="StructureTableSetupBuffer">VAR Record "API MD Structure Table Setup".</param>
    procedure InitBuffer(var StructureTableSetupBuffer: Record "API MD Structure Table Setup")
    begin
        sCommon.TestTemporaryRecord(StructureTableSetupBuffer, 'StructureTableSetup');

        StructureTableSetupBuffer.Reset();
        StructureTableSetupBuffer.DeleteAll(false);

        ApplyFilters();
        if GlobalStructureTableSetup.IsEmpty() then
            exit;

        GlobalStructureTableSetup.FindSet(false);
        repeat
            StructureTableSetupBuffer.Init();
            StructureTableSetupBuffer.TransferFields(GlobalStructureTableSetup, true);
            StructureTableSetupBuffer.Insert(false);
        until GlobalStructureTableSetup.Next() = 0;
    end;
    /// <summary>
    /// IsBaseTable.
    /// </summary>
    /// <param name="TableNo">Integer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsBaseTable(TableNo: Integer) IsBase: Boolean
    begin
        if not IsSetStructureCode then
            Error(ErrorStructureCodeIsNotSetup);

        SetBaseTableFilter(true);
        ApplyFilters();
        GlobalStructureTableSetup.FindFirst();
        IsBase := GlobalStructureTableSetup."Table No." = TableNo;
        SetBaseTableFilter(false);
    end;
    /// <summary>
    /// LookupRecord.
    /// </summary>
    /// <param name="StructureTableSetup">VAR Record "API MD Structure Table Setup".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure LookupRecord(var StructureTableSetup: Record "API MD Structure Table Setup"): Boolean
    var
        StructureTableSetupList: Page "API MD Structure Table Setup L";
    begin
        StructureTableSetupList.LookupMode(true);
        StructureTableSetupList.SetTableView(StructureTableSetup);
        if StructureTableSetupList.RunModal() <> Action::LookupOK then
            exit(false);

        StructureTableSetupList.GetRecord(StructureTableSetup);
        exit(true);
    end;
    /// <summary>
    /// LookupStructureCode.
    /// </summary>
    /// <param name="TableCode">VAR Integer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure LookupEntryNo(var TableCode: Code[30]): Boolean
    begin
        ApplyFilters();
        if not LookupRecord(GlobalStructureTableSetup) then
            exit(false);
        TableCode := GlobalStructureTableSetup."Table Code";
        exit(true);
    end;

    /// <summary>
    /// GetRecRefByRelationRecordId.
    /// </summary>
    /// <param name="RelationRecId">RecordId.</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetRecRefByRelationRecordId(RelationRecId: RecordId; var RecRef: RecordRef): Boolean
    var
        RelationRecRef: RecordRef;
        RelationFldRef: FieldRef;
        FldRef: FieldRef;
        StructureTableRelation: Record "API MD Struct. Table Relation";
    begin
        if not HasStructureTableSetup then
            exit(false);
        //Error(ErrorStructureTableIsNotSetup);

        if GlobalStructureTableSetup."Base Table" then
            exit(false);

        RelationRecRef.Get(RelationRecId);
        //GlobalStructureTableSetup.TestField("Table No.", RelationRecId.TableNo);

        sStructureTableRelation.SetStructureCode(GlobalStructureTableSetup."Structure Code");
        sStructureTableRelation.SetSourceTableCodeFilter(GlobalStructureTableSetup."Table Code");
        sStructureTableRelation.SetStatusActiveFilter();
        if not sStructureTableRelation.GetSetOf(StructureTableRelation) then
            exit(false);

        RecRef.Open(GlobalStructureTableSetup."Table No.");
        StructureTableRelation.FindSet(false);
        repeat
            FldRef := RecRef.Field(StructureTableRelation."Field No.");

            StructureTableRelation.TestField("Relation Type");
            case StructureTableRelation."Relation Type" of
                StructureTableRelation."Relation Type"::Const:
                    begin
                        StructureTableRelation.TestField("Relation Value");
                        FldRef.SetRange(StructureTableRelation."Relation Value");
                    end;

                StructureTableRelation."Relation Type"::Filter:
                    begin
                        StructureTableRelation.TestField("Relation Value");
                        FldRef.SetFilter(StructureTableRelation."Relation Value");
                    end;

                StructureTableRelation."Relation Type"::Field:
                    begin
                        StructureTableRelation.TestField("Relation Field No.");
                        RelationFldRef := RelationRecRef.Field(StructureTableRelation."Relation Field No.");
                        FldRef.SetRange(RelationFldRef.Value);
                    end;
            end;
        until StructureTableRelation.Next() = 0;
        exit(not RecRef.IsEmpty());
    end;
}
