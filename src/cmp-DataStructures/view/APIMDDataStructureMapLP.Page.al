/// <summary>
/// component: Data Structures
/// </summary>
page 50008 "API MD Data Structure Map LP"
{
    ApplicationArea = All;
    Caption = 'API MD Data Structure Map LP';
    PageType = ListPart;
    SourceTable = "API MD Data Structure Map";
    UsageCategory = None;
    DelayedInsert = true;
    SourceTableView = sorting("Sorting Order");
    //CardPageId = "API MD Structure Map Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                FreezeColumn = "Node Name";
                IndentationColumn = Rec."Indent Level";
                IndentationControls = "Node Name";
                ShowAsTree = true;
                field("Structure Code"; Rec."Structure Code")
                {
                    ToolTip = 'Specifies the value of the Structure Code field.';
                    Visible = false;
                }
                field("Node No."; Rec."Node No.")
                {
                    ToolTip = 'Specifies the value of the Node No. field.';
                    Visible = false;
                }
                field("Node Name"; Rec."Node Name")
                {
                    ToolTip = 'Specifies the value of the Node Name field.';
                }
                field("Parent Node No."; Rec."Parent Node No.")
                {
                    ToolTip = 'Specifies the value of the Parent Node No. field.';
                    Visible = false;
                }
                field("Parent Node Name"; Rec."Parent Node Name")
                {
                    ToolTip = 'Specifies the value of the Parent Node Name field.';
                    trigger OnDrillDown()
                    begin
                        LookupParentNodeNo();
                    end;
                }
                field("Table Setup Entry No."; Rec."Table Code")
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
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        NewTableCode: Code[30];
                    begin
                        Rec.TestField("Structure Code");
                        sStructureTableSetup.SetStructureCode(Rec."Structure Code");
                        if sStructureTableSetup.LookupTableCode(NewTableCode) then
                            Rec.Validate("Table Code", NewTableCode);
                        Rec.CalcFields("Table No.", "Table Setup Name");
                    end;
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
                field("Default Value"; Rec."Default Value")
                {
                    ToolTip = 'Specifies the value of the Default Value field.';
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
                field("Indent Level"; Rec."Indent Level")
                {
                    Visible = false;
                }
                field("Sorting Order"; Rec."Sorting Order")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("New Line")
            {
                Caption = 'New Line';
                Image = New;
                trigger OnAction()
                begin
                    Rec.Init();
                    Rec.Insert(true);
                end;
            }
            action("Clear Parent Node")
            {
                Caption = 'Clear Parent Node';
                Image = ClearFilter;
                trigger OnAction()
                begin
                    Rec.Rename(Rec."Structure Code", Rec."Node No.", 0);
                    CurrPage.Update(false);
                end;
            }
            action("Update Indent")
            {
                Caption = 'Update Indent';
                Image = Indent;
                trigger OnAction()
                begin
                    sStructureMap.SetStructureCode(Rec."Structure Code");
                    sStructureMap.UpdateIndentAndSorting();
                    CurrPage.Update(false);
                end;
            }
        }
    }
    var
        sStructureMap: Codeunit "API MD Structure Map Service";
        sStructureTableSetup: Codeunit "API MD Struct Tbl Set. Service";
        sCommon: Codeunit "API MD Common Service";
        IsShowAsTree: Boolean;

    local procedure LookupParentNodeNo()
    var
        StructureMap: Record "API MD Data Structure Map";
    begin
        Rec.TestField("Structure Code");
        StructureMap.Reset();
        StructureMap.SetRange("Structure Code", Rec."Structure Code");
        StructureMap.SetFilter("Node No.", '<>%1', Rec."Node No.");
        if sStructureMap.LookupRecord(StructureMap) then
            Rec."Parent Node No." := StructureMap."Node No.";
        Rec.CalcFields("Parent Node Name");
    end;
}
