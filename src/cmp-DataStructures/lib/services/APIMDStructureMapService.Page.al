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
        GlobalStructureCode: Code[30];
        IsSetStructureCode: Boolean;
        GlobalStatusFilter: Enum "API MD Status";
        IsSetStatusFilter: Boolean;
        IsInit: Boolean;
        ErrorStructureMapIsNotSetUp: Label 'Structure Map is not initialized. Use SetStructureMap function first.';

    /// <summary>
    /// SetStructureMap.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="NodeNo">Integer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetStructureMap(StructureCode: Code[30]; NodeNo: Integer): Boolean
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
    /// Init.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure Init(): Boolean
    begin
        GlobalStructureMap.Reset();
        GlobalStructureMap.SetCurrentKey("Structure Code", "Node No.", Status);
        if IsSetStructureCode then
            GlobalStructureMap.SetRange("Structure Code", GlobalStructureCode);
        if IsSetStatusFilter then
            GlobalStructureMap.SetRange(Status, GlobalStatusFilter);
        IsInit := not GlobalStructureMap.IsEmpty();
        exit(IsInit);
    end;
    /// <summary>
    /// CopyStructureMapToBuffer.
    /// </summary>
    /// <param name="StructureMapBuffer">VAR Record "API MD Data Structure Map".</param>
    procedure CopyStructureMapToBuffer(var StructureMapBuffer: Record "API MD Data Structure Map")
    begin
        sCommon.TestTemporaryRecord(StructureMapBuffer, 'StructureMapBuffer');

        StructureMapBuffer.Reset();
        StructureMapBuffer.DeleteAll(false);

        if not IsInit then
            exit;

        GlobalStructureMap.FindSet(false);
        repeat
            StructureMapBuffer.Init();
            StructureMapBuffer.TransferFields(GlobalStructureMap, true);
            StructureMapBuffer.Insert(false);
        until GlobalStructureMap.Next() = 0;
    end;
}
