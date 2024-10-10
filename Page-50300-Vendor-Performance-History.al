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
            action(FilterByMetric)
            {
                ApplicationArea = All;
                Caption = 'Filter by Metric';
                Image = Filter;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Apply a filter to show only specific performance metrics.';

                trigger OnAction()
                var
                    FilterOptions: Text;
                    SelectedFilter: Integer;
                begin
                    FilterOptions := 'Overall Performance,On-Time Delivery,Quality Rating,Price Competitiveness,Response Time';
                    SelectedFilter := StrMenu(FilterOptions, 1, 'Select a metric to filter by:');
                    case SelectedFilter of
                        1:
                            Rec.SetFilter("Overall Performance Score", '>0');
                        2:
                            Rec.SetFilter("On-Time Delivery Rate", '>0');
                        3:
                            Rec.SetFilter("Quality Rating", '>0');
                        4:
                            Rec.SetFilter("Price Competitiveness Score", '>0');
                    end;
                    CurrPage.Update(false);
                end;
            }
        }
    }

    views
    {
        view(AllMetrics)
        {
            Caption = 'All Metrics';
            Filters = where("Overall Performance Score" = filter('>0'));
        }
        view(OnTimeDelivery)
        {
            Caption = 'On-Time Delivery';
            Filters = where("On-Time Delivery Rate" = filter('>0'));
        }
        view(QualityRating)
        {
            Caption = 'Quality Rating';
            Filters = where("Quality Rating" = filter('>0'));
        }
        view(PriceCompetitiveness)
        {
            Caption = 'Price Competitiveness';
            Filters = where("Price Competitiveness Score" = filter('>0'));
        }
    }

    var
        DrillDownField: Text;

    trigger OnOpenPage()
    begin
        if DrillDownField <> '' then
            SetFilterForField(DrillDownField);
    end;

    procedure SetDrillDownField(FieldName: Text)
    begin
        DrillDownField := FieldName;
    end;

    local procedure SetFilterForField(FieldName: Text)
    begin
        case FieldName of
            'Overall Performance Score':
                Rec.SetFilter("Overall Performance Score", '>0');
            'On-Time Delivery Rate':
                Rec.SetFilter("On-Time Delivery Rate", '>0');
            'Quality Rating':
                Rec.SetFilter("Quality Rating", '>0');
            'Price Competitiveness Score':
                Rec.SetFilter("Price Competitiveness Score", '>0');
        end;
    end;
}