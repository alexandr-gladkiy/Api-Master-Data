/// <summary>
/// component: Data Structure
/// </summary>
page 50010 "API MD Struct. Table Rel. List"
{
    ApplicationArea = All;
    Caption = 'API MD Struct. Table Rel. List';
    PageType = List;
    SourceTable = "API MD Struct. Table Relation";
    UsageCategory = None;

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
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Relation Type"; Rec."Relation Type")
                {
                    ToolTip = 'Specifies the value of the Relation Type field.';
                }
                field("Relation Value"; Rec."Relation Value")
                {
                    ToolTip = 'Specifies the value of the Relation Value field.';
                }
                field("Source Entry No."; Rec."Source Entry No.")
                {
                    ToolTip = 'Specifies the value of the Source Entry No. field.';
                }
                field("Source Table No."; Rec."Source Table No.")
                {
                    ToolTip = 'Specifies the value of the Source Table No. field.';
                }
                field("Source Table Name"; Rec."Source Table Name")
                {
                    ToolTip = 'Specifies the value of the Source Table Name field.';
                }
                field("Source Field No."; Rec."Source Field No.")
                {
                    ToolTip = 'Specifies the value of the Source Field No. field.';
                }
                field("Source Field Name"; Rec."Source Field Name")
                {
                    ToolTip = 'Specifies the value of the Source Field Name field.';
                }
                field("Target Entry No."; Rec."Relation Entry No.")
                {
                    ToolTip = 'Specifies the value of the Target Entry No. field.';
                }
                field("Target Table No."; Rec."Relation Table No.")
                {
                    ToolTip = 'Specifies the value of the Target Table No. field.';
                }
                field("Target Table Name"; Rec."Target Table Name")
                {
                    ToolTip = 'Specifies the value of the Target Table Name field.';
                }
                field("Target Field No."; Rec."Relation Field No.")
                {
                    ToolTip = 'Specifies the value of the Target Field No. field.';
                }
                field("Target Field Name"; Rec."Target Field Name")
                {
                    ToolTip = 'Specifies the value of the Target Field Name field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
