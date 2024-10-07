pageextension 50300 "Vendor Card Ext" extends "Vendor Card"
{
    layout
    {
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
                }
                field("On-Time Delivery Rate"; Rec."On-Time Delivery Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the on-time delivery rate of the vendor.';
                    StyleExpr = OnTimeDeliveryStyle;
                }
                field("Quality Rating"; Rec."Quality Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quality rating of the vendor.';
                    StyleExpr = QualityRatingStyle;
                }
                field("Price Competitiveness Score"; Rec."Price Competitiveness Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price competitiveness score of the vendor.';
                    StyleExpr = PriceCompetitivenessStyle;
                }
                field("Response Time Rating"; Rec."Response Time Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the response time rating of the vendor.';
                    StyleExpr = ResponseTimeStyle;
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
        if Score >= 80 then
            exit('Favorable');
        if Score >= 60 then
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
}