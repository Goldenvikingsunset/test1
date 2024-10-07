pageextension 50302 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addfirst(factboxes)
        {
            part(VendorPerformanceFactbox; "Vendor Performance Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                UpdatePropagation = SubPart;
            }
        }
    }
}