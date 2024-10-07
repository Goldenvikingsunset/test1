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
                field("Overall Performance Score"; Rec."Overall Performance Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the overall performance score of the vendor.';

                    trigger OnDrillDown()
                    var
                        VendorPerformanceHistory: Page "Vendor Performance History";
                    begin
                        VendorPerformanceHistory.SetRecord(Rec);
                        VendorPerformanceHistory.Run();
                    end;
                }
                field(PerformanceIndicator; GetPerformanceIndicator())
                {
                    ApplicationArea = All;
                    Caption = 'Performance Indicator';
                    ToolTip = 'Displays a visual indicator of the vendor''s performance.';
                    Editable = false;
                }
                field("Performance Trend"; Rec."Performance Trend")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the trend of the vendor''s performance.';
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

    local procedure GetPerformanceIndicator(): Text
    begin
        case true of
            Rec."Overall Performance Score" >= 80:
                exit('⭐⭐⭐');  // High performance
            Rec."Overall Performance Score" >= 60:
                exit('⭐⭐');   // Medium performance
            else
                exit('⭐');    // Low performance
        end;
    end;
}