/// <summary>
/// component: Data Structures
/// </summary>
page 50011 "API MD Structure Map Card"
{
    ApplicationArea = All;
    Caption = 'API MD Structure Map Card';
    PageType = Card;
    SourceTable = "API MD Data Structure Map";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group("Gen. Left")
                {
                    ShowCaption = false;
                    field("Structure Code"; Rec."Structure Code")
                    {
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the Structure Code field.';
                    }
                    field("Node No."; Rec."Node No.")
                    {
                        ToolTip = 'Specifies the value of the Node No. field.';
                        Visible = false;
                    }
                    field("Node Name"; Rec."Node Name")
                    {
                        Importance = Promoted;
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
                    field(Status; Rec.Status)
                    {
                        ToolTip = 'Specifies the value of the Status field.';
                    }
                }

                group("Gen. Right")
                {
                    ShowCaption = false;
                    field("Table Setup Entry No."; Rec."Table Setup Entry No.")
                    {
                        ToolTip = 'Specifies the value of the Table Setup Entry No. field.';
                    }
                    field("Table No."; Rec."Table No.")
                    {
                        ToolTip = 'Specifies the value of the Table No. field.';
                        Visible = false;
                    }
                    field("Table Name"; Rec."Table Setup Name")
                    {
                        ToolTip = 'Specifies the value of the Table Name field.';
                    }
                    field("Field No."; Rec."Field No.")
                    {
                        ToolTip = 'Specifies the value of the Field No. field.';
                        Visible = false;
                    }
                    field("Field Name"; Rec."Field Name")
                    {
                        ToolTip = 'Specifies the value of the Field Name field.';
                        trigger OnDrillDown()
                        var
                            NewFieldNo: Integer;
                        begin
                            Rec.CalcFields("Table No.");
                            Rec.TestField("Table No.");
                            if sCommon.LookupFieldNo(Rec."Table No.", NewFieldNo) then
                                Rec.Validate("Field No.", NewFieldNo);
                            Rec.CalcFields("Field Name");
                        end;
                    }
                    field("Field Validate"; Rec."Field Validate")
                    {
                        ToolTip = 'Specifies the value of the Field Validate field.';
                    }
                    field(Mondatory; Rec.Mondatory)
                    {
                        ToolTip = 'Specifies the value of the Mondatory field.';
                    }
                    field("Indent Level"; Rec."Indent Level")
                    {
                        ToolTip = 'Specifies the value of the Indent Level field.';
                        Visible = false;
                    }
                    field("Sorting Order"; Rec."Sorting Order")
                    {
                        ToolTip = 'Specifies the value of the Sorting Order field.';
                        Visible = false;
                    }
                }
            }
        }
    }
    var
        sCommon: Codeunit "API MD Common Service";
}
