/// <summary>
/// component: Data Structures
/// </summary>
table 50003 "API MD Data Structure"
{
    Caption = 'API MD Data Structure';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(3; "Structure Type"; Enum "API MD Data Structure Type")
        {
            Caption = 'Structure Type';
        }
        field(4; Direction; Enum "API MD Direction Type")
        {
            Caption = 'Direction';
        }
        field(5; Status; Enum "API MD Status")
        {
            Caption = 'Status';
        }
        field(100; "Node Count"; Integer)
        {
            Caption = 'Node Count';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("API MD Data Structure Map" where("Structure Code" = field(Code)));
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(Key1; "Structure Type", Code, Status)
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Name, "Structure Type", Direction)
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
            mDataStructure.ValidateTblDataStructureOnInsert(Rec);
        OnAfterOnInsert(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModify(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblDataStructureOnModify(Rec);
        OnAfterOnModify(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDelete(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblDataStructureOnDelete(Rec);
        OnAfterOnDelete(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRename(Rec, IsHandled);
        if not IsHandled then
            mDataStructure.ValidateTblDataStructureOnRename(Rec);
        OnAfterOnRename(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDelete(var DataStructure: Record "API MD Data Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsert(var DataStructure: Record "API MD Data Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModify(var DataStructure: Record "API MD Data Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRename(var DataStructure: Record "API MD Data Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var DataStructure: Record "API MD Data Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var DataStructure: Record "API MD Data Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModify(var DataStructure: Record "API MD Data Structure"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRename(var DataStructure: Record "API MD Data Structure"; var IsHandled: Boolean)
    begin
    end;
}
