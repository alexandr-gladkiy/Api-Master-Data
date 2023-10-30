/// <summary>
/// component: Data Structures
/// </summary>
codeunit 50007 "API MD Structure Management"
{
    var
        sStructure: Codeunit "API MD Structure Service";
        sStructureMap: Codeunit "API MD Structure Map Service";
        sStructureTableSetup: Codeunit "API MD Struct Tbl Set. Service";
        sStructureTableRelation: Codeunit "API MD Struct Tbl Rel Service";
    /// <summary>
    /// ValidateTblDataStructureOnInsert.
    /// </summary>
    /// <param name="DataStructure">Record "API MD Data Structure".</param>
    procedure ValidateTblDataStructureOnInsert(DataStructure: Record "API MD Data Structure")
    begin

    end;
    /// <summary>
    /// ValidateTblDataStructureOnModify.
    /// </summary>
    /// <param name="DataStructure">Record "API MD Data Structure".</param>
    procedure ValidateTblDataStructureOnModify(DataStructure: Record "API MD Data Structure")
    begin

    end;
    /// <summary>
    /// ValidateTblDataStructureOnDelete.
    /// </summary>
    /// <param name="DataStructure">Record "API MD Data Structure".</param>
    procedure ValidateTblDataStructureOnDelete(DataStructure: Record "API MD Data Structure")
    begin

    end;
    /// <summary>
    /// ValidateTblDataStructureOnRename.
    /// </summary>
    /// <param name="DataStructure">Record "API MD Data Structure".</param>
    procedure ValidateTblDataStructureOnRename(DataStructure: Record "API MD Data Structure")
    begin

    end;
    /// <summary>
    /// ValidateTblDataStructureMapOnInsert.
    /// </summary>
    /// <param name="DataStructureMap">VAR Record "API MD Data Structure Map".</param>
    procedure ValidateTblDataStructureMapOnInsert(var DataStructureMap: Record "API MD Data Structure Map")
    begin
        SetStructureMapNodeNo(DataStructureMap);
    end;

    local procedure SetStructureMapNodeNo(var DataStructureMap: Record "API MD Data Structure Map")
    begin
        DataStructureMap.TestField("Structure Code");
        sStructureMap.SetStructureCode(DataStructureMap."Structure Code");
        DataStructureMap."Node No." := sStructureMap.GetLastNodeNo() + 1;
    end;
    /// <summary>
    /// ValidateTblDataStructureMapOnModify.
    /// </summary>
    /// <param name="DataStructureMap">Record "API MD Data Structure Map".</param>
    procedure ValidateTblDataStructureMapOnModify(DataStructureMap: Record "API MD Data Structure Map")
    begin

    end;
    /// <summary>
    /// ValidateTblDataStructureMapOnDelete.
    /// </summary>
    /// <param name="DataStructureMap">Record "API MD Data Structure Map".</param>
    procedure ValidateTblDataStructureMapOnDelete(DataStructureMap: Record "API MD Data Structure Map")
    begin

    end;
    /// <summary>
    /// ValidateTblDataStructureMapOnRename.
    /// </summary>
    /// <param name="DataStructureMap">Record "API MD Data Structure Map".</param>
    procedure ValidateTblDataStructureMapOnRename(DataStructureMap: Record "API MD Data Structure Map")
    begin

    end;

    /// <summary>
    /// ValidateTblStructureTableSetupOnInsert.
    /// </summary>
    /// <param name="StructureTableSetup">VAR Record "API MD Structure Table Setup".</param>
    procedure ValidateTblStructureTableSetupOnInsert(var StructureTableSetup: Record "API MD Structure Table Setup")
    begin
        SetStructureTableSetupEntryNo(StructureTableSetup);
    end;

    local procedure SetStructureTableSetupEntryNo(var StructureTableSetup: Record "API MD Structure Table Setup")
    begin
        StructureTableSetup.TestField("Structure Code");
        sStructureTableSetup.SetStructureCode(StructureTableSetup."Structure Code");
        StructureTableSetup."Entry No." := sStructureTableSetup.GetLastEntryNo() + 1;
    end;
    /// <summary>
    /// ValidateTblStructureTableSetupOnModify.
    /// </summary>
    /// <param name="StructureTableSetup">Record "API MD Structure Table Setup".</param>
    procedure ValidateTblStructureTableSetupOnModify(StructureTableSetup: Record "API MD Structure Table Setup")
    begin

    end;
    /// <summary>
    /// ValidateTblStructureTableSetupOnDelete.
    /// </summary>
    /// <param name="StructureTableSetup">Record "API MD Structure Table Setup".</param>
    procedure ValidateTblStructureTableSetupOnDelete(StructureTableSetup: Record "API MD Structure Table Setup")
    begin

    end;
    /// <summary>
    /// ValidateTblStructureTableSetupOnRename.
    /// </summary>
    /// <param name="StructureTableSetup">Record "API MD Structure Table Setup".</param>
    procedure ValidateTblStructureTableSetupOnRename(StructureTableSetup: Record "API MD Structure Table Setup")
    begin

    end;
    /// <summary>
    /// ValidateTblStructureTableRelationOnInsert.
    /// </summary>
    /// <param name="StructureTableRelation">VAR Record "API MD Struct. Table Relation".</param>
    procedure ValidateTblStructureTableRelationOnInsert(var StructureTableRelation: Record "API MD Struct. Table Relation")
    begin
        SetStructureTableRelationLineNo(StructureTableRelation);
    end;

    local procedure SetStructureTableRelationLineNo(var StructureTableRelation: Record "API MD Struct. Table Relation")
    begin
        StructureTableRelation.TestField("Structure Code");
        sStructureTableRelation.SetStructureCode(StructureTableRelation."Structure Code");
        StructureTableRelation."Line No." := sStructureTableRelation.GetLastLineNo() + 1;
    end;
    /// <summary>
    /// ValidateTblStructureTableRelationOnModify.
    /// </summary>
    /// <param name="StructureTableRelation">Record "API MD Struct. Table Relation".</param>
    procedure ValidateTblStructureTableRelationOnModify(StructureTableRelation: Record "API MD Struct. Table Relation")
    begin

    end;
    /// <summary>
    /// ValidateTblStructureTableRelationOnDelete.
    /// </summary>
    /// <param name="StructureTableRelation">Record "API MD Struct. Table Relation".</param>
    procedure ValidateTblStructureTableRelationOnDelete(StructureTableRelation: Record "API MD Struct. Table Relation")
    begin

    end;
    /// <summary>
    /// ValidateTblStructureTableRelationOnRename.
    /// </summary>
    /// <param name="StructureTableRelation">Record "API MD Struct. Table Relation".</param>
    procedure ValidateTblStructureTableRelationOnRename(StructureTableRelation: Record "API MD Struct. Table Relation")
    begin

    end;
}
