codeunit 50300 "Performance Calculation"
{
    procedure CalculateOverallPerformance(VendorNo: Code[20]): Decimal
    var
        OnTimeDelivery, Quality, PriceComp, ResponseTime : Decimal;
    begin
        OnTimeDelivery := CalculateOnTimeDeliveryRate(VendorNo);
        Quality := CalculateQualityRating(VendorNo);
        PriceComp := CalculatePriceCompetitiveness(VendorNo);

        // Calculate overall score (equal weights for simplicity)
        exit(Round((OnTimeDelivery + Quality + PriceComp) / 3, 0.01));
    end;

    procedure CalculateOnTimeDeliveryRate(VendorNo: Code[20]): Decimal
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        TotalLineItems, OnTimeLineItems : Integer;
    begin
        PurchRcptLine.SetRange("Buy-from Vendor No.", VendorNo);
        PurchRcptLine.SetRange("Posting Date", CalcDate('<-1Y>', WorkDate()), WorkDate());
        PurchRcptLine.SetFilter(Quantity, '<>0');  // Ensure we only count lines with actual items

        if PurchRcptLine.FindSet() then
            repeat
                TotalLineItems += 1;
                if (PurchRcptLine."Posting Date" <= PurchRcptLine."Expected Receipt Date") and
                (PurchRcptLine."Expected Receipt Date" <> 0D) then
                    OnTimeLineItems += 1;
            until PurchRcptLine.Next() = 0;


        if TotalLineItems > 0 then
            exit(OnTimeLineItems / TotalLineItems * 100)
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
                if ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Purchase then begin
                    TotalQuantity += Abs(ItemLedgerEntry.Quantity);
                    AcceptedQuantity += ItemLedgerEntry.Quantity; // This will subtract returns automatically
                end;
            until ItemLedgerEntry.Next() = 0;

        if TotalQuantity > 0 then
            exit(Round((AcceptedQuantity / TotalQuantity) * 100, 0.01))
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

}