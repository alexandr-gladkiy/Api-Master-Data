/// <summary>
/// component: Data Structure
/// </summary>
codeunit 50010 "API MD Struct Tbl Set. Service"
{
    var
        sCommon: Codeunit "API MD Common Service";
        GlobalStructureTableSetup: Record "API MD Structure Table Setup";
        HasStructureTableSetup: Boolean;
        ErrorStructureIsNotSetup: Label 'Structure is not initialized. Use SetStructureTableSetup function first.';

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
    /// <param name="EntryNo">Integer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetByPK(StructuteCode: Code[30]; EntryNo: Integer): Boolean
    begin
        HasStructureTableSetup := GlobalStructureTableSetup.Get(StructuteCode, EntryNo);
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
    /// GetLastEntryNo.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetLastEntryNo(): Integer
    begin
        if not IsSetStructureCode then
            Error(ErrorStructureCodeIsNotSetup);

        ApplyFilters();
        if GlobalStructureTableSetup.IsEmpty() then
            exit(0);

        GlobalStructureTableSetup.FindLast();
        exit(GlobalStructureTableSetup."Entry No.");
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
    /// <param name="EntryNo">VAR Integer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure LookupEntryNo(var EntryNo: Integer): Boolean
    begin
        ApplyFilters();
        if not LookupRecord(GlobalStructureTableSetup) then
            exit(false);
        EntryNo := GlobalStructureTableSetup."Entry No.";
        exit(true);
    end;
}
