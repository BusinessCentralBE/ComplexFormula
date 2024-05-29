codeunit 50101 "STA Avg. Net. Cost Formula" implements "STA Complex Formula Int."
{
    procedure Calculate(TargetRecord: RecordRef; TriggerRecord: RecordRef) Result: Text
    var
        PurchaseLine: Record "Purchase Line";
        TriggerPurchLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        TotalLines: Integer;
        TotalNetCost: Decimal;
        AvgNetCost: Decimal;
    begin
        if TargetRecord.Number <> Database::"Purchase Header" then
            exit;

        TargetRecord.SetTable(PurchaseHeader);
        TriggerRecord.SetTable(TriggerPurchLine);

        TotalLines := 1;
        if TriggerPurchLine.Quantity > 0 then
            TotalNetCost += (TriggerPurchLine."Unit Cost" - (TriggerPurchLine."Line Discount Amount" / TriggerPurchLine.Quantity))
        else
            TotalNetCost += TriggerPurchLine."Unit Cost";

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter("Line No.", '<>%1', TriggerPurchLine."Line No.");
        PurchaseLine.SetRange(Type, Enum::"Purchase Line Type"::Item);
        if PurchaseLine.FindSet() then
            repeat
                TotalLines += 1;
                if PurchaseLine.Quantity > 0 then
                    TotalNetCost += (PurchaseLine."Unit Cost" - (PurchaseLine."Line Discount Amount" / PurchaseLine.Quantity))
                else
                    TotalNetCost += PurchaseLine."Unit Cost";
            until PurchaseLine.Next() < 1;

        AvgNetCost := Round(TotalNetCost / TotalLines, 0.01);

        exit(Format(AvgNetCost));
    end;
}