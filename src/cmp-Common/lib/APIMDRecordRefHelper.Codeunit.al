/// <summary>
/// component: Common
/// </summary>
codeunit 50012 "API MD Record Ref. Helper"
{
    /// <summary>
    /// LookupRecordRefByTableNo.
    /// </summary>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <param name="SourceTableNo">Integer.</param>
    /// <param name="FilterString">Text.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure LookupRecordRefByTableNo(var RecRef: RecordRef; SourceTableNo: Integer; FilterString: Text): Boolean
    var
        RecVariant: Variant;
    begin
        RecRef.Open(SourceTableNo);
        if FilterString <> '' then
            RecRef.SetView(FilterString);
        RecRef.FindSet(false);
        RecVariant := RecRef;
        if Page.RunModal(0, RecVariant) = Action::LookupOK then begin
            RecRef := RecVariant;
            exit(true);
        end;
        exit(false);
    end;
}
