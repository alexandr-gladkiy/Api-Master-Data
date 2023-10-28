/// <summary>
/// component: Data Structures
/// </summary>
codeunit 50011 "API MD Struct Tbl Rel Service"
{
    var
        GlobalStructureTableRelation: Record "API MD Struct. Table Relation";
        HasStructureTableRelation: Boolean;
        ErrorStructureIsNotSetup: Label 'Structure Table Relation is not initialized';
        GlobalStructureCode: Code[30];
        IsSetStructureCode: Boolean;
        ErrorStructureCodeIsNotSetup: Label 'Structure Code is not initialized. Use SetStructureCode function first.';

    /// <summary>
    /// SetByPK.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="LineNo">Integer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetByPK(StructureCode: Code[30]; LineNo: Integer): Boolean
    begin
        HasStructureTableRelation := GlobalStructureTableRelation.Get(StructureCode, LineNo);
        exit(HasStructureTableRelation);
    end;
    /// <summary>
    /// Clear.
    /// </summary>
    procedure Clear()
    begin
        ClearAll();
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
        GlobalStructureTableRelation.Reset();
        GlobalStructureTableRelation.SetCurrentKey("Structure Code", "Line No.");
        if IsSetStructureCode then
            GlobalStructureTableRelation.SetRange("Structure Code", GlobalStructureCode);
    end;
    /// <summary>
    /// GetLastLineNo.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetLastLineNo(): Integer
    begin
        if not IsSetStructureCode then
            Error(ErrorStructureCodeIsNotSetup);

        ApplyFilters();
        if GlobalStructureTableRelation.IsEmpty() then
            exit(0);

        GlobalStructureTableRelation.FindLast();
        exit(GlobalStructureTableRelation."Line No.");
    end;
}
