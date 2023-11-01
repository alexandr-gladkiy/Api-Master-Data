/// <summary>
/// component: Data Structures
/// </summary>
interface "API MD IStructure"
{
    /// <summary>
    /// GenerateDataAsText.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="DataAsText">VAR Text.</param>
    procedure ExportDataAsText(StructureCode: Code[30]; var RecRef: RecordRef; var DataAsText: Text)

    /// <summary>
    /// GenerateDataAsFile.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="FileName">Text.</param>
    procedure ExportDataAsFile(StructureCode: Code[30]; var RecRef: RecordRef; FileName: Text);

    /// <summary>
    /// GenerateDataAsBlob.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="TempBlob">VAR Codeunit "Temp Blob".</param>
    procedure ExportDataAsBlob(StructureCode: Code[30]; var RecRef: RecordRef; var TempBlob: Codeunit "Temp Blob");

    /// <summary>
    /// GenerateDataAsStream.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="IStream">VAR InStream.</param>
    procedure ExportDataAsStream(StructureCode: Code[30]; var RecRef: RecordRef; var IStream: InStream);
}
