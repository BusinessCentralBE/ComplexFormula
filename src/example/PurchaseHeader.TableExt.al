tableextension 50101 "STA Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50100; "STA Average Netto Unit Cost"; Text[250])
        {
            Caption = 'Average Netto Unit Cost';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("STA Complex Formula".Result where(Formula = const("Average Netto Unit Cost"), "Table No." = const(38), "Record ID" = field(SystemId)));
        }
    }
}