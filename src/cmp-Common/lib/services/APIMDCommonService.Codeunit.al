/// <summary>
/// component: Common
/// </summary>
codeunit 50002 "API MD Common Service"
{
    var
        ErrorVariantNotIsRecord: Label 'Rec not is Record';
    /// <summary>
    /// TestEmpty.
    /// </summary>
    /// <param name="VarValue">Variant.</param>
    /// <param name="ErrorMessage">Text.</param>
    procedure TestEmpty(VarValue: Variant; ErrorMessage: Text)
    var
        TextValue: Text;
        GuidValue: Guid;
        IntValue: Integer;
        BigIntValue: BigInteger;
        DecimalValue: Decimal;
        ErrorParameterIsEmpty: Label '%1 parameter is empty';
    begin
        if VarValue.IsCode or VarValue.IsText then begin
            Evaluate(TextValue, VarValue);
            if TextValue = '' then
                Error(ErrorParameterIsEmpty, ErrorMessage);
        end;
        if VarValue.IsGuid then begin
            Evaluate(GuidValue, VarValue);
            if IsNullGuid(GuidValue) then
                Error(ErrorParameterIsEmpty, ErrorMessage);
        end;
        if VarValue.IsInteger then begin
            IntValue := VarValue;
            if IntValue = 0 then
                Error(ErrorParameterIsEmpty, ErrorMessage);
        end;
        if VarValue.IsDecimal then begin
            DecimalValue := VarValue;
            if DecimalValue = 0 then
                Error(ErrorParameterIsEmpty, ErrorMessage);
        end;
        if VarValue.IsBigInteger then begin
            BigIntValue := VarValue;
            if BigIntValue = 0 then
                Error(ErrorParameterIsEmpty, ErrorMessage);
        end;
    end;
    /// <summary>
    /// TestTemporaryRecord.
    /// </summary>
    /// <param name="Rec">Variant.</param>
    /// <param name="RecVarName">Text.</param>
    procedure TestTemporaryRecord(Rec: Variant; RecVarName: Text)
    var
        RecRef: RecordRef;
        ErrorRecordMustBeTemporary: Label 'Record %1 must be temporary.';
    begin
        if not Rec.IsRecord then
            Error(ErrorVariantNotIsRecord);
        RecRef.GetTable(Rec);
        if not RecRef.IsTemporary() then
            Error(ErrorRecordMustBeTemporary, RecVarName)
    end;
}
