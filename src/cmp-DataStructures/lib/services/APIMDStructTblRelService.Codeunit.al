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
        GlobalRelationTableCodeFilter: Code[30];
        IsSetRelationTableCodeFilter: Boolean;
        GlobalSourceTableCodeFilter: Code[30];
        IsSetSourceTableCodeFilter: Boolean;
        GlobalStatus: Enum "API MD Status";
        IsSetStatusFilter: Boolean;
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
    /// <summary>
    /// SetTableCodeFilter.
    /// </summary>
    /// <param name="TableCode">Code[30].</param>
    procedure SetSourceTableCodeFilter(TableCode: Code[30])
    begin
        GlobalSourceTableCodeFilter := TableCode;
        IsSetSourceTableCodeFilter := true;
    end;
    /// <summary>
    /// SetRelationTableCodeFilter.
    /// </summary>
    /// <param name="RelationTableCode">Integer.</param>
    procedure SetRelationTableCodeFilter(RelationTableCode: Code[30])
    begin
        GlobalRelationTableCodeFilter := RelationTableCode;
        IsSetRelationTableCodeFilter := true;
    end;
    /// <summary>
    /// SetStatusActiveFilter.
    /// </summary>
    procedure SetStatusActiveFilter()
    begin
        GlobalStatus := GlobalStatus::Active;
        IsSetStatusFilter := true;
    end;

    local procedure ApplyFilters(var StructureTableRelation: Record "API MD Struct. Table Relation")
    begin
        StructureTableRelation.Reset();
        StructureTableRelation.SetCurrentKey("Structure Code", "Relation Table Code", Status);
        if IsSetStructureCode then
            StructureTableRelation.SetRange("Structure Code", GlobalStructureCode);
        if IsSetRelationTableCodeFilter then
            StructureTableRelation.SetRange("Relation Table Code", GlobalRelationTableCodeFilter);
        if IsSetStatusFilter then
            StructureTableRelation.SetRange("Status", GlobalStatus);
        if IsSetSourceTableCodeFilter then
            StructureTableRelation.SetRange("Source Table Code", GlobalSourceTableCodeFilter);
    end;
    /// <summary>
    /// GetSetOf.
    /// </summary>
    /// <param name="StructureTableRelation">VAR Record "API MD Struct. Table Relation".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetSetOf(var StructureTableRelation: Record "API MD Struct. Table Relation"): Boolean
    begin
        ApplyFilters(StructureTableRelation);
        exit(not StructureTableRelation.IsEmpty())
    end;
    /// <summary>
    /// GetLastLineNo.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetLastLineNo(): Integer
    begin
        if not IsSetStructureCode then
            Error(ErrorStructureCodeIsNotSetup);

        ApplyFilters(GlobalStructureTableRelation);
        if GlobalStructureTableRelation.IsEmpty() then
            exit(0);

        GlobalStructureTableRelation.FindLast();
        exit(GlobalStructureTableRelation."Line No.");
    end;
}
