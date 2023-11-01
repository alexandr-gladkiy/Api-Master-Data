/// <summary>
/// component: Data Structures
/// </summary>
codeunit 50014 "API MD Structure JSON Impl." implements "API MD IStructure"
{
    /// <summary>
    /// ExportDataAsText.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="DataAsText">VAR Text.</param>
    procedure ExportDataAsText(StructureCode: Code[30]; var RecRef: RecordRef; var DataAsText: Text)
    begin
    end;
    /// <summary>
    /// ExportDataAsFile.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="FileName">Text.</param>
    procedure ExportDataAsFile(StructureCode: Code[30]; var RecRef: RecordRef; FileName: Text)
    begin
    end;
    /// <summary>
    /// ExportDataAsBlob.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="TempBlob">VAR Codeunit "Temp Blob".</param>
    procedure ExportDataAsBlob(StructureCode: Code[30]; var RecRef: RecordRef; var TempBlob: Codeunit "Temp Blob")
    begin
    end;
    /// <summary>
    /// ExportDataAsStream.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="IStream">VAR InStream.</param>
    procedure ExportDataAsStream(StructureCode: Code[30]; var RecRef: RecordRef; var IStream: InStream)
    begin
    end;
}
