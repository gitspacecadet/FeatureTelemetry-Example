tableextension 50100 "Sales Header Ext." extends "Sales Header"
{
    procedure SquareGetMaxPaymentAmount(): Decimal
    // Returns maximum available amount for payment
    var
        TotalSalesLine: Record "Sales Line";
        OutstandingAmount: Decimal;
    begin
        // Calculate Sales Document Outstanding Amount
        TotalSalesLine.SetRange("Document Type", Rec."Document Type");
        TotalSalesLine.SetRange("Document No.", Rec."No.");
        if TotalSalesLine.Findset() then begin
            TotalSalesLine.CalcSums("Amount Including VAT");
            OutstandingAmount := TotalSalesLine."Amount Including VAT";
        end;

        exit(OutstandingAmount);
    end;
}
