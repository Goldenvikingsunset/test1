pageextension 50301 "Vendor List Ext" extends "Vendor List"
{
    layout
    {
        addfirst(factboxes)
        {
            part(VendorPerformanceFactbox; "Vendor Performance Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
}