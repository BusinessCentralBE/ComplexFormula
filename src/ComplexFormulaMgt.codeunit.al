codeunit 50100 "STA Complex Formula Mgt."
{
    procedure Calculate(ComplexFormulas: enum "STA Complex Formulas"; TargetRecord: Variant; TriggerRecord: Variant)
    var
        ComplexFormula: Record "STA Complex Formula";
        TypeHelper: Codeunit "Type Helper";
        ComplexFormulaImpl: interface "STA Complex Formula Int.";
        TargetRecordRef: RecordRef;
        TriggerRecordRef: RecordRef;
    begin
        if not TargetRecord.IsRecord() then
            exit;

        TypeHelper.CopyRecVariantToRecRef(TargetRecord, TargetRecordRef);
        TypeHelper.CopyRecVariantToRecRef(TriggerRecord, TriggerRecordRef);
        ComplexFormulaImpl := ComplexFormulas;
        GetRecord(ComplexFormulas, ComplexFormula, TargetRecordRef.Number, TargetRecordRef.Field(TargetRecordRef.SystemIdNo).Value);
        ComplexFormula.SaveResult(ComplexFormulaImpl.Calculate(TargetRecordRef, TriggerRecordRef));
    end;

    local procedure GetRecord(ComplexFormulas: enum "STA Complex Formulas"; var ComplexFormula: Record "STA Complex Formula"; TableNo: Integer; RecordId: Guid)
    begin
        if not ComplexFormula.Get(ComplexFormulas, TableNo, RecordId) then
            ComplexFormula.Create(ComplexFormulas, TableNo, RecordId);
    end;
}