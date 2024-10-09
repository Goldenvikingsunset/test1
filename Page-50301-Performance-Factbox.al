page 50301 "Vendor Performance Factbox"
{
    PageType = CardPart;
    SourceTable = Vendor;
    Caption = 'Vendor Performance';

    layout
    {
        area(content)
        {
            group(Performance)
            {
                Caption = 'Performance Summary';
                field("Overall Performance"; GetOverallPerformanceText())
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the overall performance of the vendor.';
                    StyleExpr = OverallStyle;
                }
                field("On-Time Delivery"; GetOnTimeDeliveryText())
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the on-time delivery rate of the vendor.';
                    StyleExpr = DeliveryStyle;
                }
                field("Quality"; GetQualityText())
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the quality rating of the vendor.';
                    StyleExpr = QualityStyle;
                }
                field("Price Competitiveness"; GetPriceCompText())
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the price competitiveness of the vendor.';
                    StyleExpr = PriceStyle;
                }
                field("Response Time"; GetResponseTimeText())
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the response time rating of the vendor.';
                    StyleExpr = ResponseStyle;
                }
                field("Performance Trend"; Rec."Performance Trend")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the trend of the vendor''s performance.';
                    StyleExpr = TrendStyle;
                }
                field("Last Evaluation Date"; Rec."Last Evaluation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the last performance evaluation.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewFullReport)
            {
                ApplicationArea = All;
                Caption = 'View Full Report';
                Image = Report;
                RunObject = Page "Vendor Performance History";
                RunPageLink = "Vendor No." = FIELD("No.");
                ToolTip = 'Opens the full vendor performance history report.';
            }
        }
    }

    var
        OverallStyle: Text;
        DeliveryStyle: Text;
        QualityStyle: Text;
        PriceStyle: Text;
        ResponseStyle: Text;
        TrendStyle: Text;

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    local procedure SetStyles()
    begin
        OverallStyle := GetStyleForScore(Rec."Overall Performance Score");
        DeliveryStyle := GetStyleForScore(Rec."On-Time Delivery Rate");
        QualityStyle := GetStyleForScore(Rec."Quality Rating");
        PriceStyle := GetStyleForScore(Rec."Price Competitiveness Score");
        ResponseStyle := GetStyleForScore(Rec."Response Time Rating");
        TrendStyle := GetTrendStyle();
    end;

    local procedure GetStyleForScore(Score: Decimal): Text
    begin
        case true of
            Score >= 60:
                exit('Favorable');
            Score >= 40:
                exit('Ambiguous');
            else
                exit('Unfavorable');
        end;
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

    local procedure GetOverallPerformanceText(): Text
    begin
        exit(StrSubstNo('Overall: %1%', Format(Round(Rec."Overall Performance Score", 0.1))));
    end;

    local procedure GetOnTimeDeliveryText(): Text
    begin
        exit(StrSubstNo('Delivery: %1%', Format(Round(Rec."On-Time Delivery Rate", 0.1))));
    end;

    local procedure GetQualityText(): Text
    begin
        exit(StrSubstNo('Quality: %1%', Format(Round(Rec."Quality Rating", 0.1))));
    end;

    local procedure GetPriceCompText(): Text
    begin
        exit(StrSubstNo('Price: %1%', Format(Round(Rec."Price Competitiveness Score", 0.1))));
    end;

    local procedure GetResponseTimeText(): Text
    begin
        exit(StrSubstNo('Response: %1%', Format(Round(Rec."Response Time Rating", 0.1))));
    end;
}