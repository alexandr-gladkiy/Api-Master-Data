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
    DelayedInsert = true;

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
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Visible = false;
                }
                field("Relation Type"; Rec."Relation Type")
                {
                    ToolTip = 'Specifies the value of the Relation Type field.';
                }
                field("Relation Value"; Rec."Relation Value")
                {
                    ToolTip = 'Specifies the value of the Relation Value field.';
                }
                field("Source Table Code"; Rec."Source Table Code")
                {
                    ToolTip = 'Specifies the value of the Source Entry No. field.';
                    //Visible = false;
                }
                field("Source Table No."; Rec."Table No.")
                {
                    ToolTip = 'Specifies the value of the Source Table No. field.';
                    Visible = false;
                }
                field("Source Table Name"; Rec."Source Table Name")
                {
                    ToolTip = 'Specifies the value of the Source Table Name field.';
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        NewTableCode: Code[30];
                    begin
                        sStructureTableSetup.SetStructureCode(Rec."Structure Code");
                        if sStructureTableSetup.LookupTableCode(NewTableCode) then
                            Rec.Validate("Source Table Code", NewTableCode);
                        Rec.CalcFields("Table No.", "Source Table Name");
                    end;
                }
                field("Source Field No."; Rec."Field No.")
                {
                    ToolTip = 'Specifies the value of the Source Field No. field.';
                    Visible = false;
                }
                field("Source Field Name"; Rec."Source Field Name")
                {
                    ToolTip = 'Specifies the value of the Source Field Name field.';
                    trigger OnDrillDown()
                    var
                        NewFieldNo: Integer;
                    begin
                        Rec.CalcFields("Table No.");
                        Rec.TestField("Table No.");
                        if sCommon.LookupFieldNo(Rec."Table No.", NewFieldNo) then
                            Rec.Validate("Field No.", NewFieldNo);
                        Rec.CalcFields("Source Field Name");
                    end;
                }
                field("Relation Table Code"; Rec."Relation Table Code")
                {
                    ToolTip = 'Specifies the value of the Relation Table Code field.';
                    //Visible = false;
                }
                field("Relation Table No."; Rec."Relation Table No.")
                {
                    ToolTip = 'Specifies the value of the Relation Table No. field.';
                    Visible = false;
                }
                field("Relation Table Name"; Rec."Relation Table Name")
                {
                    ToolTip = 'Specifies the value of the Relation Table Name field.';
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        NewTableCode: Code[30];
                    begin
                        sStructureTableSetup.SetStructureCode(Rec."Structure Code");
                        if sStructureTableSetup.LookupTableCode(NewTableCode) then
                            Rec.Validate("Relation Table Code", NewTableCode);
                        Rec.CalcFields("Relation Table No.", "Relation Table Name");
                    end;
                }
                field("Relation Field No."; Rec."Relation Field No.")
                {
                    ToolTip = 'Specifies the value of the Relation Field No. field.';
                    Visible = false;
                }
                field("Relation Field Name"; Rec."Relation Field Name")
                {
                    ToolTip = 'Specifies the value of the Relation Field Name field.';
                    trigger OnDrillDown()
                    var
                        NewFieldNo: Integer;
                    begin
                        Rec.CalcFields("Relation Table No.");
                        Rec.TestField("Relation Table No.");
                        if sCommon.LookupFieldNo(Rec."Relation Table No.", NewFieldNo) then
                            Rec.Validate("Relation Field No.", NewFieldNo);
                        Rec.CalcFields("Relation Field Name");
                    end;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    var
        sStructureTableSetup: Codeunit "API MD Struct Tbl Set. Service";
        sCommon: Codeunit "API MD Common Service";
}
