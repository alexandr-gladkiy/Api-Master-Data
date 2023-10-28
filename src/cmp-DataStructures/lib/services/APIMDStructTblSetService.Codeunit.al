/// <summary>
/// component: Data Structure
/// </summary>
codeunit 50010 "API MD Struct Tbl Set. Service"
{
    var
        GlobalStructureTableSetup: Record "API MD Structure Table Setup";
        HasStructureTableSetup: Boolean;
        ErrorStructureIsNotSetup: Label 'Structure is not initialized. Use SetStructureTableSetup function first.';
        GlobalStructureCode: Code[30];
        IsSetStructureCode: Boolean;
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
    /// SetStructureCode.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    procedure SetStructureCode(StructureCode: Code[30])
    begin
        GlobalStructureCode := StructureCode;
        IsSetStructureCode := true;
    end;

    local procedure ApplyFilters()
    begin
        GlobalStructureTableSetup.Reset();
        GlobalStructureTableSetup.SetCurrentKey("Structure Code", "Entry No.");
        if IsSetStructureCode then
            GlobalStructureTableSetup.SetRange("Structure Code", GlobalStructureCode);
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
