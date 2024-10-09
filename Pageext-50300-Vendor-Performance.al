pageextension 50300 "Vendor Card Ext" extends "Vendor Card"
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

        addlast(General)
        {
            group(Performance)
            {
                Caption = 'Performance';

                field("Overall Performance Score"; Rec."Overall Performance Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the overall performance score of the vendor.';
                    StyleExpr = OverallPerformanceStyle;
                    DrillDown = true;
                    DrillDownPageId = "Vendor Performance History";

                    trigger OnDrillDown()
                    begin
                        OpenVendorPerformanceHistory('');
                    end;
                }
                field("On-Time Delivery Rate"; Rec."On-Time Delivery Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the on-time delivery rate of the vendor.';
                    StyleExpr = OnTimeDeliveryStyle;
                    DrillDown = true;
                    DrillDownPageId = "Vendor Performance History";

                    trigger OnDrillDown()
                    begin
                        OpenVendorPerformanceHistory('On-Time Delivery Rate');
                    end;
                }
                field("Quality Rating"; Rec."Quality Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quality rating of the vendor.';
                    StyleExpr = QualityRatingStyle;
                    DrillDown = true;
                    DrillDownPageId = "Vendor Performance History";

                    trigger OnDrillDown()
                    begin
                        OpenVendorPerformanceHistory('Quality Rating');
                    end;
                }
                field("Price Competitiveness Score"; Rec."Price Competitiveness Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price competitiveness score of the vendor.';
                    StyleExpr = PriceCompetitivenessStyle;
                    DrillDown = true;
                    DrillDownPageId = "Vendor Performance History";

                    trigger OnDrillDown()
                    begin
                        OpenVendorPerformanceHistory('Price Competitiveness Score');
                    end;
                }
                field("Response Time Rating"; Rec."Response Time Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the response time rating of the vendor.';
                    StyleExpr = ResponseTimeStyle;
                    DrillDown = true;
                    DrillDownPageId = "Vendor Performance History";

                    trigger OnDrillDown()
                    begin
                        OpenVendorPerformanceHistory('Response Time Rating');
                    end;
                }
                field("Last Evaluation Date"; Rec."Last Evaluation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the last performance evaluation.';
                }
                field("Performance Trend"; Rec."Performance Trend")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the trend of the vendor''s performance.';
                    StyleExpr = PerformanceTrendStyle;
                }
            }

        }
    }

    actions
    {
        addlast(processing)
        {
            action(CalculatePerformance)
            {
                ApplicationArea = All;
                Caption = 'Calculate Performance';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Calculate the performance metrics for this vendor.';

                trigger OnAction()
                var
                    PerformanceDataCollection: Codeunit "Performance Data Collection";
                begin
                    PerformanceDataCollection.CollectPerformanceData(Rec."No.");
                    CurrPage.Update(false);
                end;
            }
            action(ViewPerformanceHistory)
            {
                ApplicationArea = All;
                Caption = 'View Performance History';
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Vendor Performance History";
                RunPageLink = "Vendor No." = field("No.");
                ToolTip = 'View the performance history for this vendor.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    var
        OverallPerformanceStyle: Text;
        OnTimeDeliveryStyle: Text;
        QualityRatingStyle: Text;
        PriceCompetitivenessStyle: Text;
        ResponseTimeStyle: Text;
        PerformanceTrendStyle: Text;

    local procedure SetStyles()
    begin
        OverallPerformanceStyle := GetPerformanceStyle(Rec."Overall Performance Score");
        OnTimeDeliveryStyle := GetPerformanceStyle(Rec."On-Time Delivery Rate");
        QualityRatingStyle := GetPerformanceStyle(Rec."Quality Rating");
        PriceCompetitivenessStyle := GetPerformanceStyle(Rec."Price Competitiveness Score");
        ResponseTimeStyle := GetPerformanceStyle(Rec."Response Time Rating");
        PerformanceTrendStyle := GetTrendStyle();
    end;

    local procedure GetPerformanceStyle(Score: Decimal): Text
    begin
        if Score >= 60 then
            exit('Favorable');
        if Score >= 40 then
            exit('Ambiguous');
        exit('Unfavorable');
    end;

    local procedure GetTrendStyle(): Text
    begin
        case Rec."Performance Trend" of
            Rec."Performance Trend"::Improving:
                exit('Favorable');
            Rec."Performance Trend"::Stable:
                exit('Ambiguous');
            Rec."Performance Trend"::Declining:
                exit('Unfavorable');
        end;
    end;

    local procedure OpenVendorPerformanceHistory(FieldName: Text)
    var
        VendorPerformanceHistory: Record "Vendor Performance History";
        VendorPerformanceHistoryPage: Page "Vendor Performance History";
    begin
        VendorPerformanceHistory.SetRange("Vendor No.", Rec."No.");
        VendorPerformanceHistoryPage.SetTableView(VendorPerformanceHistory);
        VendorPerformanceHistoryPage.SetDrillDownField(FieldName);
        VendorPerformanceHistoryPage.Run();
    end;
}