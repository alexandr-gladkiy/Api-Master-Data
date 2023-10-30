/// <summary>
/// component: Data Structures
/// </summary>
codeunit 50008 "API MD Structure Service"
{
    var
        sCommon: Codeunit "API MD Common Service";
        mStructure: Codeunit "API MD Structure Management";
        GlobalStructure: Record "API MD Data Structure";
        HasStructure: Boolean;
        ErrorStructureIsNotSetup: Label 'Structure is not initialized. Use SetStructure function first.';

        GlobalStructureCode: Code[30];
        IsSetStructureCode: Boolean;
        GlobalStatusFilter: Enum "API MD Status";
        IsSetStatusFilter: Boolean;
        GlobalTypeFilter: Enum "API MD Data Structure Type";
        IsSetTypeFilter: Boolean;

        ErrorValueIsEmpty: Label '%1 is empty!';

    /// <summary>
    /// SetStructure.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetByPK(StructureCode: Code[30]): Boolean
    begin
        if HasStructure and (GlobalStructure.Code = StructureCode) then
            exit(true);

        HasStructure := GlobalStructure.Get(StructureCode);
        exit(HasStructure);
    end;
    /// <summary>
    /// ClearStructure.
    /// </summary>
    procedure ClearStructure()
    begin
        ClearAll();
    end;
    /// <summary>
    /// IsActive.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsActive(): Boolean
    begin
        if not HasStructure then
            Error(ErrorStructureIsNotSetup);
        exit(GlobalStructure.Status = GlobalStructure.Status::Active);
    end;
    /// <summary>
    /// GetName.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetName(): Text
    begin
        if not HasStructure then
            Error(ErrorStructureIsNotSetup);
        exit(GlobalStructure.Name);
    end;
    /// <summary>
    /// GetStructureType.
    /// </summary>
    /// <returns>Return value of type Enum "API MD Data Structure Type".</returns>
    procedure GetStructureType(): Enum "API MD Data Structure Type"
    begin
        if not HasStructure then
            Error(ErrorStructureIsNotSetup);
        exit(GlobalStructure."Structure Type");
    end;
    /// <summary>
    /// GetDirection.
    /// </summary>
    /// <returns>Return value of type Enum "API MD Direction Type".</returns>
    procedure GetDirection(): Enum "API MD Direction Type"
    begin
        if not HasStructure then
            Error(ErrorStructureIsNotSetup);
        exit(GlobalStructure.Direction);
    end;
    /// <summary>
    /// GetNodeCount.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetNodeCount(): Integer
    begin
        if not HasStructure then
            Error(ErrorStructureIsNotSetup);
        GlobalStructure.CalcFields("Node Count");
        exit(GlobalStructure."Node Count");
    end;
    /// <summary>
    /// LookupRecord.
    /// </summary>
    /// <param name="DataStructure">VAR Record "API MD Data Structure".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure LookupRecord(var DataStructure: Record "API MD Data Structure"): Boolean
    var
        DataStructureList: Page "API MD Data Structure List";
    begin
        DataStructureList.LookupMode(true);
        DataStructureList.SetTableView(DataStructure);
        if DataStructureList.RunModal() <> Action::LookupOK then
            exit(false);

        DataStructureList.GetRecord(DataStructure);
    end;
    /// <summary>
    /// LookupStructureCode.
    /// </summary>
    /// <param name="StructureCode">VAR Code[30].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure LookupStructureCode(var StructureCode: Code[30]): Boolean
    begin
        ApplyFilters();
        if not LookupRecord(GlobalStructure) then
            exit(false);
        StructureCode := GlobalStructure.Code;
        exit(true);
    end;
    /// <summary>
    /// SetStructureCode.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    procedure SetStructureCode(StructureCode: Code[30])
    begin
        sCommon.TestEmpty(StructureCode, 'Structure Code');
        GlobalStructureCode := StructureCode;
        IsSetStructureCode := true;
    end;
    /// <summary>
    /// SetStatusFilter.
    /// </summary>
    /// <param name="Status">Enum "API MD Status".</param>
    procedure SetStatusFilter(Status: Enum "API MD Status")
    begin
        GlobalStatusFilter := Status;
        IsSetStatusFilter := true;
    end;
    /// <summary>
    /// SetTypeFilter.
    /// </summary>
    /// <param name="StructureType">Enum "API MD Data Structure Type".</param>
    procedure SetTypeFilter(StructureType: Enum "API MD Data Structure Type")
    begin
        GlobalTypeFilter := StructureType;
        IsSetTypeFilter := true;
    end;

    local procedure ApplyFilters()
    begin
        GlobalStructure.Reset;
        GlobalStructure.SetCurrentKey("Structure Type", Code, Status);

        if IsSetStructureCode then
            GlobalStructure.SetRange(Code, GlobalStructureCode);
        if IsSetTypeFilter then
            GlobalStructure.SetRange("Structure Type", GlobalTypeFilter);
        if IsSetStatusFilter then
            GlobalStructure.SetRange(Status, GlobalStatusFilter);
    end;

    local procedure ApplyTypeFilter()
    begin
        if not IsSetTypeFilter then
            exit;

        GlobalStructure.SetCurrentKey("Structure Type", Code, Status);
        GlobalStructure.SetRange("Structure Type", GlobalTypeFilter);
    end;
    /// <summary>
    /// OpenStructureTestCard.
    /// </summary>
    /// <param name="Structure">Record "API MD Data Structure".</param>
    procedure OpenStructureTestCard(Structure: Record "API MD Data Structure")
    var
        StructureTestCard: Page "API MD Structure Test Card";
    begin
        StructureTestCard.SetStructureCode(Structure.Code);
        StructureTestCard.Run();
    end;
    /// <summary>
    /// GenerateDataAsTextImpl.
    /// </summary>
    /// <param name="StructureCode">Code[20].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="DataAsText">VAR Text.</param>
    procedure GenerateDataAsTextImpl(StructureCode: Code[20]; var RecRef: RecordRef; var DataAsText: Text)
    begin
        StructureImplementationFactory(StructureCode).GenerateDataAsText(StructureCode, RecRef, DataAsText);
    end;
    /// <summary>
    /// GenerateDataAsFileImpl.
    /// </summary>
    /// <param name="StructureCode">Code[20].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="FileName">Text.</param>
    procedure GenerateDataAsFileImpl(StructureCode: Code[20]; var RecRef: RecordRef; FileName: Text)
    begin
        StructureImplementationFactory(StructureCode).GenerateDataAsFile(StructureCode, RecRef, FileName);
    end;
    /// <summary>
    /// GenerateDataAsBlobImpl.
    /// </summary>
    /// <param name="StructureCode">Code[20].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="TempBlob">VAR Codeunit "Temp Blob".</param>
    procedure GenerateDataAsBlobImpl(StructureCode: Code[20]; var RecRef: RecordRef; var TempBlob: Codeunit "Temp Blob")
    begin
        StructureImplementationFactory(StructureCode).GenerateDataAsBlob(StructureCode, RecRef, TempBlob);
    end;
    /// <summary>
    /// GenerateDataAsStreamImpl.
    /// </summary>
    /// <param name="StructureCode">Code[20].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="IStream">VAR InStream.</param>
    procedure GenerateDataAsStreamImpl(StructureCode: Code[20]; var RecRef: RecordRef; var IStream: InStream)
    begin
        StructureImplementationFactory(StructureCode).GenerateDataAsStream(StructureCode, RecRef, IStream);
    end;

    local procedure StructureImplementationFactory(StructureCode: Code[30]): Interface "API MD IStructure"
    var
        StructureTypeImpl: Enum "API MD Structure Type Impl.";
    begin
        sCommon.TestEmpty(StructureCode, StrSubstNo(ErrorValueIsEmpty, 'Structure Code'));
        SetStructureCode(StructureCode);
        ApplyFilters();
        case GlobalStructure."Structure Type" of
            GlobalStructure."Structure Type"::XML:
                exit(StructureTypeImpl::XML);
            GlobalStructure."Structure Type"::JSON:
                exit(StructureTypeImpl::JSON);
        end;
    end;
}
