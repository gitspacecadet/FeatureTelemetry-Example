pageextension 50100 "PostedSalesInvoiceExt" extends "Posted Sales Invoice"
{
    actions
    {
        addfirst("&Invoice")
        {

            group(FeatureTelemetry)
            {
                action(PaymentForm)
                {
                    ApplicationArea = All;
                    Caption = 'Add CC Payment';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = Payment;

                    trigger OnAction()
                    var
                        PaymentForm: Page "Payment Form";
                    begin
                        // Set Page payment amount
                        PaymentForm.SetParameters(Rec."No.");
                        PaymentForm.RunModal();
                    end;
                }
                action(ACHPaymentForm)
                {
                    ApplicationArea = All;
                    Caption = 'Add ACH Payment';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = ElectronicPayment;

                    trigger OnAction()
                    var
                        ACHPaymentForm: Page "ACH Payment Form";
                    begin
                        Clear(ACHPaymentForm);
                        // Set Page payment amount
                        ACHPaymentForm.SetParameters(Rec."No.");
                        ACHPaymentForm.RunModal();
                    end;
                }
            }
        }
    }
}