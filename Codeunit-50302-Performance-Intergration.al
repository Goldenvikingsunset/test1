codeunit 50302 "Vendor Perf. Integration"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        PerformanceDataCollection: Codeunit "Performance Data Collection";
    begin
        if PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice] then
            PerformanceDataCollection.CollectPerformanceData(PurchaseHeader."Buy-from Vendor No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure OnAfterPostPurchaseReceipt(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        PerformanceDataCollection: Codeunit "Performance Data Collection";
    begin
        if PurchRcpHdrNo <> '' then
            PerformanceDataCollection.CollectPerformanceData(PurchaseHeader."Buy-from Vendor No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertPurchaseQuote(var Rec: Record "Purchase Header")
    var
        PerformanceDataCollection: Codeunit "Performance Data Collection";
    begin
        if Rec."Document Type" = Rec."Document Type"::Quote then
            PerformanceDataCollection.CollectPerformanceData(Rec."Buy-from Vendor No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyPurchaseQuote(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header")
    var
        PerformanceDataCollection: Codeunit "Performance Data Collection";
    begin
        if (Rec."Document Type" = Rec."Document Type"::Quote) and (Rec."Buy-from Vendor No." <> '') and (Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No.") then
            PerformanceDataCollection.CollectPerformanceData(Rec."Buy-from Vendor No.");
    end;
}