page 50100 "Payment Form"
{
    PageType = List;
    Caption = 'Add CC Payment';
    layout
    {
        area(Content)
        {
            field(OriginalPaymentAmount; OriginalPaymentAmount)
            {
                Caption = 'Invoice Amount';
                ApplicationArea = all;
            }
            field(PaymentAmount; PaymentAmount)
            {
                Caption = 'Payment Amount';
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    if (PaymentAmount < 1) or (PaymentAmount > OriginalPaymentAmount) then
                        Error(PaymentAmountError);
                end;

            }
        }
    }
    var

        PaymentAmountError: Label 'Payment Amount could not be more than invoice remaining amount or less than 1.';

        PstSalesInvoice: Record "Sales Invoice Header";

        PaymentAmount, OriginalPaymentAmount : Decimal;


    trigger OnOpenPage()
    begin
        // Set Default values
        PaymentAmount := OriginalPaymentAmount;
    end;

    procedure SetParameters(InvoiceNo: code[20])
    // Sets the default parameters for the page
    begin
        PstSalesInvoice.get(InvoiceNo);
        PstSalesInvoice.CalcFields("Remaining Amount");
        OriginalPaymentAmount := PstSalesInvoice."Remaining Amount";
    end;

    procedure SetParametersSales(SalesHeaderNo: code[20]; DocType: Enum "Sales Document Type")
    // Sets the default parameters for the page
    begin
        SalesHeader.get(DocType, SalesHeaderNo);
        OriginalPaymentAmount := SquareGetMaxPaymentAmount(SalesHeader);
    end;


    procedure SquareGetMaxPaymentAmount(var Rec: Record "Sales Header"): Decimal
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