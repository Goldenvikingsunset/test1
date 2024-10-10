codeunit 50301 "Performance Data Collection"
{
    procedure CollectPerformanceData(VendorNo: Code[20])
    var
        Vendor: Record Vendor;
        PerformanceCalc: Codeunit "Performance Calculation";
    begin
        if not Vendor.Get(VendorNo) then
            exit;

        Vendor."On-Time Delivery Rate" := CollectDeliveryData(VendorNo);
        Vendor."Quality Rating" := CollectQualityData(VendorNo);
        Vendor."Price Competitiveness Score" := CollectPricingData(VendorNo);
        Vendor."Overall Performance Score" := PerformanceCalc.CalculateOverallPerformance(VendorNo);
        Vendor."Last Evaluation Date" := WorkDate();
        Vendor.Modify(true);

        CreatePerformanceHistoryEntry(Vendor);
    end;

    local procedure CollectDeliveryData(VendorNo: Code[20]): Decimal
    var
        PerformanceCalc: Codeunit "Performance Calculation";
    begin
        exit(PerformanceCalc.CalculateOnTimeDeliveryRate(VendorNo));
    end;

    local procedure CollectQualityData(VendorNo: Code[20]): Decimal
    var
        PerformanceCalc: Codeunit "Performance Calculation";
    begin
        exit(PerformanceCalc.CalculateQualityRating(VendorNo));
    end;

    local procedure CollectPricingData(VendorNo: Code[20]): Decimal
    var
        PerformanceCalc: Codeunit "Performance Calculation";
    begin
        exit(PerformanceCalc.CalculatePriceCompetitiveness(VendorNo));
    end;


    local procedure CreatePerformanceHistoryEntry(Vendor: Record Vendor)
    var
        VendorPerfHistory: Record "Vendor Performance History";
    begin
        VendorPerfHistory.Init();
        VendorPerfHistory."Entry No." := 0; // Auto-increment
        VendorPerfHistory."Vendor No." := Vendor."No.";
        VendorPerfHistory."Date" := WorkDate();
        VendorPerfHistory."Overall Performance Score" := Vendor."Overall Performance Score";
        VendorPerfHistory."On-Time Delivery Rate" := Vendor."On-Time Delivery Rate";
        VendorPerfHistory."Quality Rating" := Vendor."Quality Rating";
        VendorPerfHistory."Price Competitiveness Score" := Vendor."Price Competitiveness Score";
        VendorPerfHistory.Insert(true);
    end;
}