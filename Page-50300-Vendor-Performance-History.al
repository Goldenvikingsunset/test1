page 50300 "Vendor Performance History"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Vendor Performance History";
    Caption = 'Vendor Performance History';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number for this performance history record.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the vendor.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of this performance record.';
                }
                field("Overall Performance Score"; Rec."Overall Performance Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the overall performance score of the vendor for this record.';
                }
                field("On-Time Delivery Rate"; Rec."On-Time Delivery Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the on-time delivery rate of the vendor for this record.';
                }
                field("Quality Rating"; Rec."Quality Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quality rating of the vendor for this record.';
                }
                field("Price Competitiveness Score"; Rec."Price Competitiveness Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price competitiveness score of the vendor for this record.';
                }
                field("Response Time Rating"; Rec."Response Time Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the response time rating of the vendor for this record.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenVendorCard)
            {
                ApplicationArea = All;
                Caption = 'Vendor Card';
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Vendor Card";
                RunPageLink = "No." = field("Vendor No.");
                ToolTip = 'Open the vendor card for this performance history record.';
            }
        }
    }
}