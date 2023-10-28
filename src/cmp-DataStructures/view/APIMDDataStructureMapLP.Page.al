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
                        LookupParentNodeNo(); // TODO: Make Fix Select Parent Node
                    end;
                }
                field("Table Setup Entry No."; Rec."Table Setup Entry No.")
                {
                    ToolTip = 'Specifies the value of the Table Setup Entry No. field.';
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
                        NewEntryNo: Integer;
                    begin
                        Rec.TestField("Structure Code");
                        sStructureMap.SetStructureCode(Rec."Structure Code");
                        if sStructureTableSetup.LookupEntryNo(NewEntryNo) then
                            Rec.Validate("Table Setup Entry No.", NewEntryNo);
                        Rec.CalcFields("Table No.", "Table Name");
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
    var
        sStructureMap: Codeunit "API MD Structure Map Service";
        sStructureTableSetup: Codeunit "API MD Struct Tbl Set. Service";
        sCommon: Codeunit "API MD Common Service";

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
