/// <summary>
/// component: Data Structures
/// </summary>
codeunit 50008 "API MD Structure Service"
{
    var
        sCommon: Codeunit "API MD Common Service";
        mStructure: Codeunit "API MD Structure Management";
        GlobalStructure: Record "API MD Data Structure";
        HasStructure: Boolean;
        ErrorStructureIsNotSetup: Label 'Structure is not initialized. Use SetStructure function first.';

    /// <summary>
    /// SetStructure.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetStructure(StructureCode: Code[30]): Boolean
    begin
        if HasStructure and (GlobalStructure.Code = StructureCode) then
            exit(true);

        HasStructure := GlobalStructure.Get(StructureCode);
        exit(HasStructure);
    end;
    /// <summary>
    /// ClearStructure.
    /// </summary>
    procedure ClearStructure()
    begin
        ClearAll();
    end;
    /// <summary>
    /// IsActive.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsActive(): Boolean
    begin
        if not HasStructure then
            Error(ErrorStructureIsNotSetup);
        exit(GlobalStructure.Status = GlobalStructure.Status::Active);
    end;
    /// <summary>
    /// GetName.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetName(): Text
    begin
        if not HasStructure then
            Error(ErrorStructureIsNotSetup);
        exit(GlobalStructure.Name);
    end;
    /// <summary>
    /// GetStructureType.
    /// </summary>
    /// <returns>Return value of type Enum "API MD Data Structure Type".</returns>
    procedure GetStructureType(): Enum "API MD Data Structure Type"
    begin
        if not HasStructure then
            Error(ErrorStructureIsNotSetup);
        exit(GlobalStructure."Structure Type");
    end;
    /// <summary>
    /// GetDirection.
    /// </summary>
    /// <returns>Return value of type Enum "API MD Direction Type".</returns>
    procedure GetDirection(): Enum "API MD Direction Type"
    begin
        if not HasStructure then
            Error(ErrorStructureIsNotSetup);
        exit(GlobalStructure.Direction);
    end;
    /// <summary>
    /// GetNodeCount.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetNodeCount(): Integer
    begin
        if not HasStructure then
            Error(ErrorStructureIsNotSetup);
        GlobalStructure.CalcFields("Node Count");
        exit(GlobalStructure."Node Count");
    end;
}
