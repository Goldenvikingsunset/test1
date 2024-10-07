codeunit 50300 "Performance Calculation"
{
    procedure CalculateOverallPerformance(VendorNo: Code[20]): Decimal
    var
        OnTimeDelivery, Quality, PriceComp, ResponseTime : Decimal;
    begin
        OnTimeDelivery := CalculateOnTimeDeliveryRate(VendorNo);
        Quality := CalculateQualityRating(VendorNo);
        PriceComp := CalculatePriceCompetitiveness(VendorNo);
        ResponseTime := CalculateResponseTimeRating(VendorNo);

        // Calculate overall score (equal weights for simplicity)
        exit(Round((OnTimeDelivery + Quality + PriceComp + ResponseTime) / 4, 0.01));
    end;

    procedure CalculateOnTimeDeliveryRate(VendorNo: Code[20]): Decimal
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        TotalDeliveries, OnTimeDeliveries : Integer;
    begin
        PurchRcptHeader.SetRange("Buy-from Vendor No.", VendorNo);
        PurchRcptHeader.SetRange("Posting Date", CalcDate('<-1Y>', WorkDate()), WorkDate());

        if PurchRcptHeader.FindSet() then
            repeat
                TotalDeliveries += 1;
                if PurchRcptHeader."Posting Date" <= PurchRcptHeader."Expected Receipt Date" then
                    OnTimeDeliveries += 1;
            until PurchRcptHeader.Next() = 0;

        if TotalDeliveries > 0 then
            exit(OnTimeDeliveries / TotalDeliveries * 100)
        else
            exit(0);
    end;

    procedure CalculateQualityRating(VendorNo: Code[20]): Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity, AcceptedQuantity : Decimal;
    begin
        ItemLedgerEntry.SetRange("Source Type", ItemLedgerEntry."Source Type"::Vendor);
        ItemLedgerEntry.SetRange("Source No.", VendorNo);
        ItemLedgerEntry.SetRange("Posting Date", CalcDate('<-1Y>', WorkDate()), WorkDate());

        if ItemLedgerEntry.FindSet() then
            repeat
                TotalQuantity += ItemLedgerEntry.Quantity;
                if ItemLedgerEntry."Item Tracking" = ItemLedgerEntry."Item Tracking"::None then
                    AcceptedQuantity += ItemLedgerEntry.Quantity;
            until ItemLedgerEntry.Next() = 0;

        if TotalQuantity > 0 then
            exit(AcceptedQuantity / TotalQuantity * 100)
        else
            exit(0);
    end;

    procedure CalculatePriceCompetitiveness(VendorNo: Code[20]): Decimal
    var
        PurchaseLine: Record "Purchase Line";
        Item: Record Item;
        TotalItems, CompetitiveItems : Integer;
    begin
        PurchaseLine.SetRange("Buy-from Vendor No.", VendorNo);
        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Order Date", CalcDate('<-1Y>', WorkDate()), WorkDate());

        if PurchaseLine.FindSet() then
            repeat
                TotalItems += 1;
                if Item.Get(PurchaseLine."No.") then
                    if PurchaseLine."Direct Unit Cost" <= Item."Last Direct Cost" then
                        CompetitiveItems += 1;
            until PurchaseLine.Next() = 0;

        if TotalItems > 0 then
            exit(Round(CompetitiveItems / TotalItems * 100, 0.01))
        else
            exit(0);
    end;

    procedure CalculateResponseTimeRating(VendorNo: Code[20]): Decimal
    var
        PurchaseHeader: Record "Purchase Header";
        TotalQuotes, QuickResponses : Integer;
    begin
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Quote);
        PurchaseHeader.SetRange("Buy-from Vendor No.", VendorNo);
        PurchaseHeader.SetRange("Document Date", CalcDate('<-1Y>', WorkDate()), WorkDate());

        if PurchaseHeader.FindSet() then
            repeat
                TotalQuotes += 1;
                if (PurchaseHeader."Due Date" - PurchaseHeader."Document Date") <= 5 then
                    QuickResponses += 1;
            until PurchaseHeader.Next() = 0;

        if TotalQuotes > 0 then
            exit((QuickResponses / TotalQuotes) * 100)
        else
            exit(0);
    end;
}