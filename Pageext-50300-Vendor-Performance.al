pageextension 50300 "Vendor Card Extension" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
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
            field("Last Evaluation Date"; Rec."Last Evaluation Date")
            {
                ApplicationArea = All;
            }
            field("Performance Trend"; Rec."Performance Trend")
            {
                ApplicationArea = All;
            }
        }
    }
}