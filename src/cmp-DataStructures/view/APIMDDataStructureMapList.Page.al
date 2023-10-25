/// <summary>
/// component: Data Structures
/// </summary>
page 50007 "API MD Data Structure Map List"
{
    ApplicationArea = All;
    Caption = 'API MD Data Structure Map List';
    PageType = List;
    SourceTable = "API MD Data Structure Map";
    UsageCategory = None;
    DelayedInsert = true;
    MultipleNewLines = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Structure Code"; Rec."Structure Code")
                {
                    ToolTip = 'Specifies the value of the Structure Code field.';
                }
                field("Node No."; Rec."Node No.")
                {
                    ToolTip = 'Specifies the value of the Node No. field.';
                }
                field("Node Name"; Rec."Node Name")
                {
                    ToolTip = 'Specifies the value of the Node Name field.';
                }
                field("Parent Node No."; Rec."Parent Node No.")
                {
                    ToolTip = 'Specifies the value of the Parent Node No. field.';
                }
                field("Parent Node Name"; Rec."Parent Node Name")
                {
                    ToolTip = 'Specifies the value of the Parent Node Name field.';
                }
                field("Table Setup Entry No."; Rec."Table Setup Entry No.")
                {
                    ToolTip = 'Specifies the value of the Table Setup Entry No. field.';
                }
                field("Table No."; Rec."Table No.")
                {
                    ToolTip = 'Specifies the value of the Table No. field.';
                }
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.';
                }
                field("Field No."; Rec."Field No.")
                {
                    ToolTip = 'Specifies the value of the Field No. field.';
                }
                field("Field Name"; Rec."Field Name")
                {
                    ToolTip = 'Specifies the value of the Field Name field.';
                }
                field("Field Validate"; Rec."Field Validate")
                {
                    ToolTip = 'Specifies the value of the Field Validate field.';
                }
                field(Mondatory; Rec.Mondatory)
                {
                    ToolTip = 'Specifies the value of the Mondatory field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
