/// <summary>
/// component: Data Structures
/// </summary>
table 50005 "API MD Structure Table Setup"
{
    Caption = 'API MD Structure Table Setup';
    DataClassification = CustomerContent;
    LookupPageId = "API MD Structure Table Setup L";
    DrillDownPageId = "API MD Structure Table Setup L";

    fields
    {
        field(1; "Structure Code"; Code[30])
        {
            Caption = 'Structure Code';
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Table No."; Integer)
        {
            Caption = 'Table No.';
        }
        field(4; "Base Table"; Boolean)
        {
            Caption = 'Base Table';
        }
        field(5; "Trigger Insert"; Boolean)
        {
            Caption = 'Trigger Insert';
        }
        field(6; "Trigger Modify"; Boolean)
        {
            Caption = 'Trigger Modify';
        }
        field(7; "Trigger Delete"; Boolean)
        {
            Caption = 'Trigger Delete';
        }
        field(100; "Table Name"; Text[250])
        {
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(0), "Object ID" = field("Table No.")));
        }
    }
    keys
    {
        key(PK; "Structure Code", "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Table No.", "Table Name")
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
            mDataStructure.ValidateTblStructureTableSetupOnInsert(Rec);
        OnAfterOnInsert(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModify(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblStructureTableSetupOnModify(Rec);
        OnAfterOnModify(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDelete(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblStructureTableSetupOnDelete(Rec);
        OnAfterOnDelete(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRename(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblStructureTableSetupOnRename(Rec);
        OnAfterOnRename(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDelete(var StructureTableSetup: Record "API MD Structure Table Setup"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsert(var StructureTableSetup: Record "API MD Structure Table Setup"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModify(var StructureTableSetup: Record "API MD Structure Table Setup"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRename(var StructureTableSetup: Record "API MD Structure Table Setup"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var StructureTableSetup: Record "API MD Structure Table Setup"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var StructureTableSetup: Record "API MD Structure Table Setup"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModify(var StructureTableSetup: Record "API MD Structure Table Setup"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRename(var StructureTableSetup: Record "API MD Structure Table Setup"; var IsHandled: Boolean)
    begin
    end;
}
