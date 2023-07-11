page 50100 "Payment Form"
{
    PageType = List;
    Caption = 'Pay with Credit Card';

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
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Pay)
            {
                ApplicationArea = All;
                Caption = 'Pay';
                Promoted = true;
                PromotedIsBig = true;
                Image = Payment;

                trigger OnAction()
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
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.get(DocType, SalesHeaderNo);
        OriginalPaymentAmount := SalesHeader.SquareGetMaxPaymentAmount();
    end;
}