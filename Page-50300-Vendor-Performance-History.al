page 50300 "Vendor Performance History"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Vendor Performance History";
    Caption = 'Vendor Performance History';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
                field("Overall Performance Score"; Rec."Overall Performance Score")
                {
                    ApplicationArea = All;
                }
                field("On-Time Delivery Rate"; Rec."On-Time Delivery Rate")
                {
                    ApplicationArea = All;
                }
                field("Quality Rating"; Rec."Quality Rating")
                {
                    ApplicationArea = All;
                }
                field("Price Competitiveness Score"; Rec."Price Competitiveness Score")
                {
                    ApplicationArea = All;
                }
                field("Response Time Rating"; Rec."Response Time Rating")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}