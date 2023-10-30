/// <summary>
/// component: Data Structures
/// </summary>
codeunit 50013 "API MD Structure XML Impl." implements "API MD IStructure"
{
    /// <summary>
    /// GenerateDataAsText.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="DataAsText">VAR Text.</param>
    procedure GenerateDataAsText(StructureCode: Code[30]; var RecRef: RecordRef; var DataAsText: Text)
    begin
    end;
    /// <summary>
    /// GenerateDataAsFile.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="FileName">Text.</param>
    procedure GenerateDataAsFile(StructureCode: Code[30]; var RecRef: RecordRef; FileName: Text)
    begin
    end;
    /// <summary>
    /// GenerateDataAsBlob.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="TempBlob">VAR Codeunit "Temp Blob".</param>
    procedure GenerateDataAsBlob(StructureCode: Code[30]; var RecRef: RecordRef; var TempBlob: Codeunit "Temp Blob")
    begin
    end;
    /// <summary>
    /// GenerateDataAsStream.
    /// </summary>
    /// <param name="StructureCode">Code[30].</param>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="IStream">VAR InStream.</param>
    procedure GenerateDataAsStream(StructureCode: Code[30]; var RecRef: RecordRef; var IStream: InStream)
    begin
    end;
}
