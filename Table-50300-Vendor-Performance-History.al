table 50300 "Vendor Performance History"
{
    Caption = 'Vendor Performance History';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; "Overall Performance Score"; Decimal)
        {
            Caption = 'Overall Performance Score';
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2;
        }
        field(5; "On-Time Delivery Rate"; Decimal)
        {
            Caption = 'On-Time Delivery Rate';
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2;
        }
        field(6; "Quality Rating"; Decimal)
        {
            Caption = 'Quality Rating';
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2;
        }
        field(7; "Price Competitiveness Score"; Decimal)
        {
            Caption = 'Price Competitiveness Score';
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Vendor; "Vendor No.", "Date")
        {
        }
    }
}