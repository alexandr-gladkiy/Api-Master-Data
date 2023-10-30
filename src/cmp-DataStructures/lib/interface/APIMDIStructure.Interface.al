/// <summary>
/// component: Data Structures
/// </summary>
interface "API MD IStructure"
{
    /// <summary>
    /// GenerateDataStructureAsTextByRecordIdList.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecordIdList">List of [Text].</param>
    procedure GenerateDataAsTextByRecordIdList(StructureCode: Code[30]; RecordIdList: List of [Text]);
    /// <summary>
    /// GenerateDataStructureAsFileByRecordIdList.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecordIdList">List of [Text].</param>
    procedure GenerateDataAsFileByRecordIdList(StructureCode: Code[30]; RecordIdList: List of [Text]);
    /// <summary>
    /// GenerateDataAsBlobByRecordIdList.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecordIdList">List of [Text].</param>
    procedure GenerateDataAsBlobByRecordIdList(StructureCode: Code[30]; RecordIdList: List of [Text]);
    /// <summary>
    /// GenerateDataAsStreamByRecordIdList.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecordIdList">List of [Text].</param>
    procedure GenerateDataAsStreamByRecordIdList(StructureCode: Code[30]; RecordIdList: List of [Text]);
}
