/// <summary>
/// component: Data Structures
/// </summary>
page 50012 "API MD Structure Test Card"
{
    ApplicationArea = All;
    Caption = 'API MD Structure Test Card';
    PageType = Card;
    SourceTable = "API MD Structure Table Setup";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(StructureCode; Rec."Structure Code")
                {
                    Caption = 'Structure Code';
                    Editable = false;
                }
                field(BaseTableNo; Rec."Table No.")
                {
                    Caption = 'Base Table No.';
                    Editable = false;
                }
                field(BaseTableName; Rec."Table Name")
                {
                    Caption = 'Base Table Name';
                    Editable = false;
                }
                field(RecordIdList; GlobalRecordIdList)
                {
                    Caption = 'Record ID List';
                    Editable = true;
                    trigger OnDrillDown()
                    begin
                        LookupRecordId();
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Generate Data Structure")
            {
                Caption = 'Generate Data Structure';
                Image = CreateDocument;
                trigger OnAction()
                begin
                    CreateDataStructure();
                end;
            }
        }
    }
    var
        sCommon: Codeunit "API MD Common Service";
        sStructure: Codeunit "API MD Structure Service";
        sStructureMap: Codeunit "API MD Structure Map Service";
        sStructureTableSetup: Codeunit "API MD Struct Tbl Set. Service";
        GlobalStructureCode: Code[30];
        IsSetGlobalStructureCode: Boolean;
        GlobalRecordIdList: Text;
        ErrorStructureCodeIsEmpty: Label '%1 is empty';

    trigger OnOpenPage()
    begin
        if not IsSetGlobalStructureCode then
            Error('Structure Code is not set. Use function SetStructureCode');

        sStructureTableSetup.SetStructureCode(GlobalStructureCode);
        sStructureTableSetup.SetBaseTableFilter(true);
        sStructureTableSetup.InitBuffer(Rec);
    end;
    /// <summary>
    /// SetStructureCode.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    procedure SetStructureCode(StructureCode: Code[30])
    begin
        sCommon.TestEmpty(StructureCode, StrSubstNo(ErrorStructureCodeIsEmpty, 'Structure Code'));
        GlobalStructureCode := StructureCode;
        IsSetGlobalStructureCode := true;
    end;

    local procedure LookupRecordId()
    var
        RecRefHelper: Codeunit "API MD Record Ref. Helper";
        RecRef: RecordRef;
    begin
        if not RecRefHelper.LookupRecordRefByTableNo(RecRef, Rec."Table No.", '') then
            exit;

        if GlobalRecordIdList <> '' then
            GlobalRecordIdList += '|';
        GlobalRecordIdList += Format(RecRef.RecordId);
    end;

    local procedure CreateDataStructure()
    var
        ErrorValueIsEmpty: Label '% is empty.';
        RecordIdList: List of [Text];
    begin
        sCommon.TestEmpty(GlobalRecordIdList, StrSubstNo(ErrorValueIsEmpty, 'GlobalRecordIdList'));
        RecordIdList := GlobalRecordIdList.Split('|');
        sStructure.GenerateDataStructureAsTextByRecordIdListImpl(Rec."Structure Code", RecordIdList);
    end;
}