tableextension 50100 "STA Purchase Line" extends "Purchase Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                CalcNetPrice();
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CalcNetPrice();
            end;
        }
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                CalcNetPrice();
            end;
        }
    }

    local procedure CalcNetPrice()
    var
        ComplexFormulaMgt: Codeunit "STA Complex Formula Mgt.";
    begin
        ComplexFormulaMgt.Calculate(Enum::"STA Complex Formulas"::"Average Netto Unit Cost", GetPurchHeader(), Rec);
    end;
}