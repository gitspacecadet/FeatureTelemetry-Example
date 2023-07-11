page 50101 "ACH Payment Form"
{
    PageType = List;
    Caption = 'Pay with ACH';
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


        PstSalesInvoice: Record "Sales Invoice Header";

        SalesHeader: Record "Sales Header";
        PaymentAmount: Decimal;
        OriginalPaymentAmount: Decimal;
        PaymentAmountError: Label 'Payment Amount could not be more than invoice remaining amount or less than 1.';


    procedure SetParameters(InvNo: Code[20])
    // Sets the default parameters for the page
    begin
        PstSalesInvoice.Get(InvNo);
        PstSalesInvoice.CalcFields("Remaining Amount");
        OriginalPaymentAmount := PstSalesInvoice."Remaining Amount";
        PaymentAmount := OriginalPaymentAmount;
    end;

    procedure SetParametersSalesOrder(SalesHeaderNo: Code[20]; DocType: Enum "Sales Document Type")
    // Sets the default parameters for the page
    begin
        SalesHeader.Get(DocType, SalesHeaderNo);
        OriginalPaymentAmount := SalesHeader.SquareGetMaxPaymentAmount();
        PaymentAmount := OriginalPaymentAmount;
    end;

}