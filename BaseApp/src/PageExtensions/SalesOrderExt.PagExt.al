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
                    PromotedOnly = true;
                    Image = Payment;

                    trigger OnAction()
                    var
                        PaymentForm: Page "Payment Form";
                    begin
                        FeautureTelemetry.LogUptake('EVT000150', 'Sales Order CC Payments', FeatureUptakeStatus::Discovered, False, CustDimension);

                        Clear(PaymentForm);
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
                        FeautureTelemetry.LogUptake('EVT000170', 'Sales Order ACH Payments', FeatureUptakeStatus::Discovered, False, CustDimension);

                        // Set Page payment amount
                        ACHPaymentForm.SetParametersSalesOrder(Rec."No.", Rec."Document Type");
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

    trigger OnOpenPage()
    var

    begin
        Rec.CalcFields("Amount Including VAT");
    end;

    trigger OnAfterGetCurrRecord()
    begin

        Rec.CalcFields("Amount Including VAT");
    end;
}
