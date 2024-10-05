tableextension 50300 "Vendor Performance Extension" extends Vendor
{
    fields
    {
        field(50100; "Overall Performance Score"; Decimal)
        {
            Caption = 'Overall Performance Score';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2;
        }
        field(50101; "On-Time Delivery Rate"; Decimal)
        {
            Caption = 'On-Time Delivery Rate';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2;
        }
        field(50102; "Quality Rating"; Decimal)
        {
            Caption = 'Quality Rating';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2;
        }
        field(50103; "Price Competitiveness Score"; Decimal)
        {
            Caption = 'Price Competitiveness Score';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2;
        }
        field(50104; "Response Time Rating"; Decimal)
        {
            Caption = 'Response Time Rating';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2;
        }
        field(50105; "Last Evaluation Date"; Date)
        {
            Caption = 'Last Evaluation Date';
            DataClassification = CustomerContent;
        }
        field(50106; "Performance Trend"; Enum "Performance Trend")
        {
            Caption = 'Performance Trend';
            DataClassification = CustomerContent;
        }
    }
}