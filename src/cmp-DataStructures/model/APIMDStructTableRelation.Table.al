/// <summary>
/// component: Data Structures
/// </summary>
table 50006 "API MD Struct. Table Relation"
{
    Caption = 'API MD Struct. Table Relatio';
    DataClassification = CustomerContent;
    LookupPageId = "API MD Struct. Table Rel. List";
    DrillDownPageId = "API MD Struct. Table Rel. List";

    fields
    {
        field(1; "Structure Code"; Code[30])
        {
            Caption = 'Structure Code';
            TableRelation = "API MD Data Structure".Code;
            ValidateTableRelation = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Relation Entry No."; Integer)
        {
            Caption = 'Relation Entry No.';
            TableRelation = "API MD Structure Table Setup"."Entry No." where("Structure Code" = field("Structure Code"));
            ValidateTableRelation = true;
        }
        field(4; "Relation Table No."; Integer)
        {
            Caption = 'Relation Table No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("API MD Structure Table Setup"."Table No." where("Structure Code" = field("Structure Code"), "Entry No." = field("Relation Entry No.")));
        }
        field(5; "Relation Field No."; Integer)
        {
            Caption = 'Relation Field No.';
            TableRelation = Field."No." where(TableNo = field("Relation Table No."));
            ValidateTableRelation = true;
        }
        field(6; "Relation Type"; Enum "API MD Table Relation Type")
        {
            Caption = 'Relation Type';
        }
        field(7; "Relation Value"; Text[250])
        {
            Caption = 'Relation Value';
        }
        field(8; "Source Entry No."; Integer)
        {
            Caption = 'Source Entry No.';
            TableRelation = "API MD Structure Table Setup"."Entry No." where("Structure Code" = field("Structure Code"));
            ValidateTableRelation = true;
        }
        field(9; "Source Table No."; Integer)
        {
            Caption = 'Source Table No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("API MD Structure Table Setup"."Table No." where("Structure Code" = field("Structure Code"), "Entry No." = field("Source Entry No.")));
        }
        field(10; "Source Field No."; Integer)
        {
            Caption = 'Source Field No.';
            TableRelation = Field."No." where(TableNo = field("Source Table No."));
            ValidateTableRelation = true;
        }
        field(11; Status; Enum "API MD Status")
        {
            Caption = 'Status';
        }
        field(100; "Source Table Name"; Text[250])
        {
            Caption = 'Source Table Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(0), "Object ID" = field("Source Table No.")));
        }
        field(101; "Source Field Name"; Text[250])
        {
            Caption = 'Source Field Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Source Table No."), "No." = field("Source Field No.")));
        }
        field(102; "Relation Table Name"; Text[250])
        {
            Caption = 'Relation Table Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(0), "Object ID" = field("Relation Table No.")));
        }
        field(103; "Relation Field Name"; Text[250])
        {
            Caption = 'Relation Field Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Source Table No."), "No." = field("Relation Field No.")));
        }
    }
    keys
    {
        key(PK; "Structure Code", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Structure Code", "Line No.", "Source Table Name", "Source Field Name", "Relation Table Name", "Source Field Name", "Relation Field Name")
        {

        }
    }

    var
        mDataStructure: Codeunit "API MD Structure Management";

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblStructureTableRelationOnInsert(Rec);
        OnAfterOnInsert(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModify(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblStructureTableRelationOnModify(Rec);
        OnAfterOnModify(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDelete(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblStructureTableRelationOnDelete(Rec);
        OnAfterOnDelete(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRename(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblStructureTableRelationOnRename(Rec);
        OnAfterOnRename(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDelete(var StructureTableRelation: Record "API MD Struct. Table Relation"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsert(var StructureTableRelation: Record "API MD Struct. Table Relation"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModify(var StructureTableRelation: Record "API MD Struct. Table Relation"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRename(var StructureTableRelation: Record "API MD Struct. Table Relation"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var StructureTableRelation: Record "API MD Struct. Table Relation"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var StructureTableRelation: Record "API MD Struct. Table Relation"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModify(var StructureTableRelation: Record "API MD Struct. Table Relation"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRename(var StructureTableRelation: Record "API MD Struct. Table Relation"; var IsHandled: Boolean)
    begin
    end;
}
