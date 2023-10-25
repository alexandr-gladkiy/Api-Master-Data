/// <summary>
/// component: Data Structures
/// </summary>
table 50006 "API MD Struct. Table Relation"
{
    Caption = 'API MD Struct. Table Relatio';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Structure Code"; Code[30])
        {
            Caption = 'Structure Code';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Relation Entry No."; Integer)
        {
            Caption = 'Target Entry No.';
        }
        field(4; "Relation Table No."; Integer)
        {
            Caption = 'Target Table No.';
        }
        field(5; "Relation Field No."; Integer)
        {
            Caption = 'Target Field No.';
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
        }
        field(9; "Source Table No."; Integer)
        {
            Caption = 'Source Table No.';
        }
        field(10; "Source Field No."; Integer)
        {
            Caption = 'Source Field No.';
        }
        field(11; Status; Enum "API MD Status")
        {
            Caption = 'Status';
        }
        field(100; "Source Table Name"; Text[250])
        {
            Caption = 'Source Table Name';
        }
        field(101; "Source Field Name"; Text[250])
        {
            Caption = 'Source Field Name';
        }
        field(102; "Target Table Name"; Text[250])
        {
            Caption = 'Target Table Name';
        }
        field(103; "Target Field Name"; Text[250])
        {
            Caption = 'Target Field Name';
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
        fieldgroup(DropDown; "Structure Code", "Line No.", "Source Table Name", "Source Field Name", "Target Table Name", "Source Field Name", "Target Field Name")
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
