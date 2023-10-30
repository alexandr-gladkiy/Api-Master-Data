/// <summary>
/// component: Data Structures
/// </summary>
page 50009 "API MD Structure Table Setup L"
{
    ApplicationArea = All;
    Caption = 'API MD Structure Table Setup L';
    PageType = List;
    SourceTable = "API MD Structure Table Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Structure Code"; Rec."Structure Code")
                {
                    ToolTip = 'Specifies the value of the Structure Code field.';
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Visible = false;
                }
                field("Table No."; Rec."Table No.")
                {
                    ToolTip = 'Specifies the value of the Table No. field.';
                    Visible = false;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.';
                    trigger OnDrillDown()
                    var
                        NewTableID: Integer;
                    begin
                        if sCommon.LookupTableID(NewTableID) then
                            Rec.Validate("Table No.", NewTableID);
                        Rec.CalcFields("Table Name");
                    end;
                }
                field("Base Table"; Rec."Base Table")
                {
                    ToolTip = 'Specifies the value of the Base Table field.';
                }
                field("Trigger Insert"; Rec."Trigger Insert")
                {
                    ToolTip = 'Specifies the value of the Trigger Insert field.';
                }
                field("Trigger Modify"; Rec."Trigger Modify")
                {
                    ToolTip = 'Specifies the value of the Trigger Modify field.';
                }
                field("Trigger Delete"; Rec."Trigger Delete")
                {
                    ToolTip = 'Specifies the value of the Trigger Delete field.';
                }
            }
        }
    }
    var
        sCommon: Codeunit "API MD Common Service";
}
