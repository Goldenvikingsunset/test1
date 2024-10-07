pageextension 50303 "Purchase Quote Ext" extends "Purchase Quote"
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