/// <summary>
/// component: Data Structures
/// </summary>
codeunit 50014 "API MD Structure JSON Impl." implements "API MD IStructure"
{

    /// <summary>
    /// GenerateDataAsTextByRecordIdList.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecordIdList">List of [Text].</param>
    procedure GenerateDataAsTextByRecordIdList(StructureCode: Code[30]; RecordIdList: List of [Text])
    var
        RecordIdAsText: Text;
        RecordId: RecordId;
    begin
        foreach RecordIdAsText in RecordIdList do begin
            Evaluate(RecordId, RecordIdAsText);

        end;
    end;
    /// <summary>
    /// GenerateDataAsFileByRecordIdList.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecordIdList">List of [Text].</param>
    procedure GenerateDataAsFileByRecordIdList(StructureCode: Code[30]; RecordIdList: List of [Text])
    begin
    end;
    /// <summary>
    /// GenerateDataAsBlobByRecordIdList.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecordIdList">List of [Text].</param>
    procedure GenerateDataAsBlobByRecordIdList(StructureCode: Code[30]; RecordIdList: List of [Text])
    begin
    end;
    /// <summary>
    /// GenerateDataAsStreamByRecordIdList.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecordIdList">List of [Text].</param>
    procedure GenerateDataAsStreamByRecordIdList(StructureCode: Code[30]; RecordIdList: List of [Text])
    begin
    end;

}
