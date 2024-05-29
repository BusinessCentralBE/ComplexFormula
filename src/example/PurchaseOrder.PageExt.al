pageextension 50100 "STA Purchase Order" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("STA Average Netto Unit Cost"; Rec."STA Average Netto Unit Cost")
            {
                ApplicationArea = All;
            }
        }
    }
}