/// <summary>
/// component: Data Structures
/// </summary>
codeunit 50009 "API MD Structure Map Service"
{
    var
        sCommon: Codeunit "API MD Common Service";
        mStructure: Codeunit "API MD Structure Management";
        GlobalStructureMap: Record "API MD Data Structure Map";
        HasStructureMap: Boolean;
        IsInit: Boolean;
        ErrorStructureMapIsNotSetUp: Label 'Structure Map is not initialized.';

        GlobalStructureCode: Code[30];
        IsSetStructureCode: Boolean;
        ErrorStructureCodeIsNotSetUp: Label 'Structure Code is not set.';
        GlobalStatusFilter: Enum "API MD Status";
        IsSetStatusFilter: Boolean;
        GlobalParentNodeNoFilter: Integer;
        IsSetParentNodeNoFilter: Boolean;
        ErrorParentNodeNoFilterIsNotSetUp: Label 'Parent Node No filter is not set.';


    /// <summary>
    /// SetStructureMap.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="NodeNo">Integer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetByPK(StructureCode: Code[30]; NodeNo: Integer): Boolean
    begin
        sCommon.TestEmpty(StructureCode, 'StructureCode');
        sCommon.TestEmpty(NodeNo, 'NodeNo');
        if HasStructureMap and (GlobalStructureMap."Structure Code" = StructureCode) and (GlobalStructureMap."Node No." = NodeNo) then
            exit(true);

        HasStructureMap := GlobalStructureMap.Get(StructureCode, NodeNo);
        exit(HasStructureMap);
    end;
    /// <summary>
    /// Clear.
    /// </summary>
    procedure Clear()
    begin
        ClearAll();
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
    /// SetActiveStatusFilter.
    /// </summary>
    procedure SetActiveStatusFilter()
    begin
        SetStatusFilter(GlobalStatusFilter::Active);
    end;
    /// <summary>
    /// SetParentNodeNoFilter.
    /// </summary>
    /// <param name="ParentNodeNo">Integer.</param>
    procedure SetParentNodeNoFilter(ParentNodeNo: Integer)
    begin
        GlobalParentNodeNoFilter := ParentNodeNo;
        IsSetParentNodeNoFilter := true;
    end;
    /// <summary>
    /// GetLastNodeNo.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetLastNodeNo(): Integer
    begin
        if not IsSetStructureCode then
            Error(ErrorStructureCodeIsNotSetUp);

        if not GetSetOf(GlobalStructureMap) then
            exit(0);
        GlobalStructureMap.FindLast();
        exit(GlobalStructureMap."Node No.");
    end;
    /// <summary>
    /// GetSetOf.
    /// </summary>
    /// <param name="StructureMap">VAR Record "API MD Data Structure Map".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetSetOf(var StructureMap: Record "API MD Data Structure Map"): Boolean
    begin
        ApplyFilters(StructureMap);
        exit(not StructureMap.IsEmpty());
    end;

    /// <summary>
    /// GetSetOfBufferByParentKey.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="ParentNodeNo">Integer.</param>
    /// <param name="StructureMapBuffer">VAR Record "API MD Data Structure Map".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetSetOfBufferByParentKey(StructureCode: Code[30]; ParentNodeNo: Integer; var StructureMapBuffer: Record "API MD Data Structure Map"): Boolean
    begin
        sCommon.TestTemporaryRecord(StructureMapBuffer, 'StructureMapBuffer');
        StructureMapBuffer.Reset();
        StructureMapBuffer.SetRange("Structure Code", StructureCode);
        StructureMapBuffer.SetRange("Parent Node No.", ParentNodeNo);
        exit(not StructureMapBuffer.IsEmpty())
    end;
    /// <summary>
    /// Init.
    /// </summary>
    /// <param name="StructureMapBuffer">VAR Record "API MD Data Structure Map".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure InitBuffer(var StructureMapBuffer: Record "API MD Data Structure Map"): Boolean
    begin
        sCommon.TestTemporaryRecord(StructureMapBuffer, 'StructureMapBuffer');
        StructureMapBuffer.Reset();
        StructureMapBuffer.DeleteAll(false);

        ApplyFilters(GlobalStructureMap);
        if GlobalStructureMap.IsEmpty then
            exit(false);

        GlobalStructureMap.FindSet(false);
        repeat
            StructureMapBuffer.Init();
            StructureMapBuffer.TransferFields(GlobalStructureMap, true);
            StructureMapBuffer.Insert(false);
        until GlobalStructureMap.Next() = 0;
        exit(true);
    end;

    local procedure ApplyFilters(var StructureMap: Record "API MD Data Structure Map")
    begin
        StructureMap.Reset();
        StructureMap.SetCurrentKey("Structure Code", "Node No.", Status);
        if IsSetStructureCode then
            StructureMap.SetRange("Structure Code", GlobalStructureCode);
        if IsSetStatusFilter then
            StructureMap.SetRange(Status, GlobalStatusFilter);
        if IsSetParentNodeNoFilter then begin
            StructureMap.SetCurrentKey("Structure Code", "Parent Node No.");
            StructureMap.SetRange("Parent Node No.", GlobalParentNodeNoFilter);
        end;
    end;

    /// <summary>
    /// LookupRecord.
    /// </summary>
    /// <param name="StructureMap">VAR Record "API MD Data Structure Map".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure LookupRecord(var StructureMap: Record "API MD Data Structure Map"): Boolean
    var
        StructureMapList: Page "API MD Data Structure Map List";
    begin
        StructureMapList.LookupMode(true);
        StructureMapList.SetTableView(StructureMap);
        if StructureMapList.RunModal() <> Action::LookupOK then
            exit(false);

        StructureMapList.GetRecord(StructureMap);
        exit(true);
    end;

    /// <summary>
    /// UpdateIndentAndSorting.
    /// </summary>
    procedure UpdateIndentAndSorting()
    var
        SortingOrder: Integer;
    begin
        if not IsSetStructureCode then
            Error(ErrorStructureCodeIsNotSetUp);

        SortingOrder := 1;
        SetIndentAndSorting(0, 0, SortingOrder);
    end;

    local procedure SetIndentAndSorting(ParentNodeNo: Integer; IndentLevel: Integer; var SortingOrder: Integer)
    var
        StructureMap: Record "API MD Data Structure Map";
    begin
        if not IsSetStructureCode then
            Error(ErrorStructureCodeIsNotSetUp);

        SetParentNodeNoFilter(ParentNodeNo);
        if not GetSetOf(StructureMap) then
            exit;

        StructureMap.FindSet(true);
        repeat
            StructureMap."Indent Level" := IndentLevel;
            StructureMap."Sorting Order" := SortingOrder;
            StructureMap.Modify(true);
            SortingOrder += 1;
            SetIndentAndSorting(StructureMap."Node No.", IndentLevel + 1, SortingOrder);
        until StructureMap.Next() = 0;
    end;
}
