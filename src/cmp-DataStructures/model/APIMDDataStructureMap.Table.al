/// <summary>
/// component: Data Structures
/// </summary>
table 50004 "API MD Data Structure Map"
{
    Caption = 'API MD Data Structure Map';
    DataClassification = CustomerContent;
    LookupPageId = "API MD Data Structure Map List";
    DrillDownPageId = "API MD Data Structure Map List";

    fields
    {
        field(1; "Structure Code"; Code[30])
        {
            Caption = 'Structure Code';
            TableRelation = "API MD Data Structure".Code;
            ValidateTableRelation = true;
        }
        field(2; "Node No."; Integer)
        {
            Caption = 'Node No.';
        }
        field(3; "Node Name"; Text[50])
        {
            Caption = 'Node Name';
        }
        field(4; "Parent Node No."; Integer)
        {
            Caption = 'Parent Node No.';
            TableRelation = "API MD Data Structure Map"."Node No." where("Structure Code" = field("Structure Code"), Status = const(1));
            ValidateTableRelation = true;
        }
        field(5; Status; Enum "API MD Status")
        {
            Caption = 'Status';
        }
        field(6; "Table Setup Entry No."; Integer)
        {
            Caption = 'Table Setup Entry No.';
            TableRelation = "API MD Structure Table Setup"."Entry No." where("Structure Code" = field("Structure Code"));
            ValidateTableRelation = true;
        }
        field(7; "Table No."; Integer)
        {
            Caption = 'Table No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("API MD Structure Table Setup"."Table No." where("Structure Code" = field("Structure Code"), "Entry No." = field("Table Setup Entry No.")));
        }
        field(8; "Field No."; Integer)
        {
            Caption = 'Field No.';
            TableRelation = Field."No." where(TableNo = field("Table No."));
            ValidateTableRelation = true;
        }
        field(9; "Field Validate"; Boolean)
        {
            Caption = 'Field Validate';
        }
        field(10; Mondatory; Boolean)
        {
            Caption = 'Mondatory';
        }
        field(100; "Parent Node Name"; Text[50])
        {
            Caption = 'Parent Node Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("API MD Data Structure Map"."Node Name" where("Structure Code" = field("Structure Code")));
        }
        field(101; "Table Name"; Text[250])
        {
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(0), "Object ID" = field("Table No.")));
        }
        field(102; "Field Name"; Text[250])
        {
            Caption = 'Field Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."), "No." = field("Field No.")));
        }
    }
    keys
    {
        key(PK; "Structure Code", "Node No.")
        {
            Clustered = true;
        }
        key(UK; "Node No.", "Parent Node No.")
        {
            Unique = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Structure Code", "Node Name", Status)
        {
        }
    }

    var
        mDataStructure: Codeunit "API MD Structure Management";
        sCommon: Codeunit "API MD Common Service";

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblDataStructureMapOnInsert(Rec);
        OnAfterOnInsert(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModify(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblDataStructureMapOnModify(Rec);
        OnAfterOnModify(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDelete(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblDataStructureMapOnDelete(Rec);
        OnAfterOnDelete(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRename(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblDataStructureMapOnRename(Rec);
        OnAfterOnRename(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDelete(var DataStructureMap: Record "API MD Data Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsert(var DataStructureMap: Record "API MD Data Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModify(var DataStructureMap: Record "API MD Data Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRename(var DataStructureMap: Record "API MD Data Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var DataStructureMap: Record "API MD Data Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var DataStructureMap: Record "API MD Data Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModify(var DataStructureMap: Record "API MD Data Structure Map"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRename(var DataStructureMap: Record "API MD Data Structure Map"; var IsHandled: Boolean)
    begin
    end;
}
