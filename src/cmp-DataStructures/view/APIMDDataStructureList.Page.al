/// <summary>
/// component: Data Structures
/// </summary>
page 50005 "API MD Data Structure List"
{
    ApplicationArea = All;
    Caption = 'API MD Data Structure List';
    PageType = List;
    SourceTable = "API MD Data Structure";
    UsageCategory = Lists;
    CardPageId = "API MD Data Structure Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Direction; Rec.Direction)
                {
                    ToolTip = 'Specifies the value of the Direction field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Node Count"; Rec."Node Count")
                {
                    ToolTip = 'Specifies the value of the Node Count field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Structure Type"; Rec."Structure Type")
                {
                    ToolTip = 'Specifies the value of the Structure Type field.';
                }
            }
        }
    }
}
