pageextension 50101 "STA Purch. Order List" extends "Purchase Order List"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("STA Average Netto Unit Cost"; Rec."STA Average Netto Unit Cost")
            {
                ApplicationArea = All;
            }
        }
    }
}