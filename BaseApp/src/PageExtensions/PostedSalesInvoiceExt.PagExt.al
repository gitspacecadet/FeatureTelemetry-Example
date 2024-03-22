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
                        FeautureTelemetry.LogUptake('EVT000110', 'Posted Sales Invoice CC Payments', FeatureUptakeStatus::Discovered, False, CustDimension);

                        // Set Page payment amount
                        Clear(PaymentForm);
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
                        FeautureTelemetry.LogUptake('EVT000130', 'Posted Sales Invoice ACH Payments', FeatureUptakeStatus::Discovered, False, CustDimension);

                        Clear(ACHPaymentForm);
                        // Set Page payment amount
                        ACHPaymentForm.SetParameters(Rec."No.");
                        ACHPaymentForm.RunModal();
                    end;
                }
            }
        }
    }
    var
        FeautureTelemetry: Codeunit "Feature Telemetry";
        FeatureUptakeStatus: Enum "Feature Uptake Status";
        CustDimension: Dictionary of [Text, Text];
}