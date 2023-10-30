/// <summary>
/// component: Data Structures
/// </summary>
page 50006 "API MD Data Structure Card"
{
    ApplicationArea = All;
    Caption = 'API MD Data Structure Card';
    PageType = Card;
    SourceTable = "API MD Data Structure";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                group("General Left")
                {
                    ShowCaption = false;
                    field("Code"; Rec."Code")
                    {
                        ToolTip = 'Specifies the value of the Code field.';
                    }
                    field(Name; Rec.Name)
                    {
                        ToolTip = 'Specifies the value of the Name field.';
                    }
                    field("Structure Type"; Rec."Structure Type")
                    {
                        ToolTip = 'Specifies the value of the Structure Type field.';
                    }
                }

                group("General Right")
                {
                    ShowCaption = false;
                    field(Direction; Rec.Direction)
                    {
                        ToolTip = 'Specifies the value of the Direction field.';
                    }
                    field(Status; Rec.Status)
                    {
                        ToolTip = 'Specifies the value of the Status field.';
                    }
                    field("Node Count"; Rec."Node Count")
                    {
                        ToolTip = 'Specifies the value of the Node Count field.';
                    }

                }
            }

            part("Data Structure Map"; "API MD Data Structure Map LP")
            {
                Caption = 'Structure Map';
                SubPageLink = "Structure Code" = field(Code);
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Table Setup List")
            {
                Caption = 'Table Setup List';
                Image = SetupList;
                RunObject = Page "API MD Structure Table Setup L";
                RunPageLink = "Structure Code" = field(Code);
            }
            action("Table Relation List")
            {
                Caption = 'Table Relation List';
                Image = SetupList;
                RunObject = Page "API MD Struct. Table Rel. List";
                RunPageLink = "Structure Code" = field(Code);
            }
            action("Structure Test Card")
            {
                Caption = 'Structure Test Card';
                Image = TestDatabase;
                trigger OnAction()
                begin
                    sStructure.OpenStructureTestCard(Rec);
                end;
            }
        }
    }
    var
        sStructure: Codeunit "API MD Structure Service";
}
