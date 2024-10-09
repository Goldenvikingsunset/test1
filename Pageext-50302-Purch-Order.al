pageextension 50302 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Vendor Performance Indicator"; GetVendorPerformanceIndicator())
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Indicates the overall performance level of the selected vendor.';
                Caption = 'Vendor Performance';
            }
        }
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

    local procedure GetVendorPerformanceIndicator(): Text
    var
        Vendor: Record Vendor;
    begin
        if Vendor.Get(Rec."Buy-from Vendor No.") then
            case true of
                Vendor."Overall Performance Score" >= 60:
                    exit('★★★');
                Vendor."Overall Performance Score" >= 40:
                    exit('★★☆');
                else
                    exit('★☆☆');
            end;
        exit('');
    end;
}