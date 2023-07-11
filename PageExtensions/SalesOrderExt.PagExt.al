pageextension 50101 "SalesOrderExt" extends "Sales Order"
{

    actions
    {
        addlast(processing)
        {

            group(FeatureTelemetry)
            {
                action(PaymentFormExistingCard)
                {
                    ApplicationArea = All;
                    Caption = 'Pay with CC';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Payment;

                    trigger OnAction()
                    var
                        PaymentForm: Page "Payment Form";
                    begin
                        PaymentForm.SetParametersSales(Rec."No.", Rec."Document Type");
                        PaymentForm.RunModal();
                    end;
                }
                action(ACHPaymentForm)
                {
                    ApplicationArea = All;
                    Caption = 'Pay with ACH';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = ElectronicPayment;

                    trigger OnAction()
                    var
                        ACHPaymentForm: Page "ACH Payment Form";
                    begin
                        // Set Page payment amount
                        ACHPaymentForm.SetParametersSalesOrder(Rec."No.", Rec."Document Type");
                        ACHPaymentForm.RunModal();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var

    begin
        Rec.CalcFields("Amount Including VAT");
    end;

    trigger OnAfterGetCurrRecord()
    begin

        CalcFields("Amount Including VAT");
    end;
}
