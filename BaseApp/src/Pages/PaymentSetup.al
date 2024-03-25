page 50103 "Payment Setup"
{
    SourceTable = "Sales & Receivables Setup";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {


        area(Content)
        {
            group(PaymentMethods)
            {
                Caption = 'Payment Methods';

                field("Enable CCPayments PostedSalInv"; Rec."Enable CCPayments PostedSalInv")
                {
                    ApplicationArea = ALL;
                    Caption = 'Enable CC Payments for Posted Sales Invoices';

                    trigger OnValidate()
                    begin
                        Clear(CustDimension);
                        if Rec."Enable CCPayments PostedSalInv" then
                            CustDimension.Add('Posted Sal Invoice CC Payment status', 'Enabled')
                        else
                            CustDimension.Add('Posted Sal Invoice CC Payment status', 'Disabled');

                        FeautureTelemetry.LogUptake('EVT000190', 'Posted Sales Invoice CC Payments', FeatureUptakeStatus::"Set up", false, CustDimension);
                    end;
                }
                field("Enable ACHPayment PostedSalInv"; Rec."Enable ACHPayment PostedSalInv")
                {
                    ApplicationArea = ALL;
                    Caption = 'Enable ACH Payments for Posted Sales Invoices';

                    trigger OnValidate()
                    begin
                        Clear(CustDimension);
                        if Rec."Enable ACHPayment PostedSalInv" then
                            CustDimension.Add('Posted Sal Invoice ACH Payment status', 'Enabled')
                        else
                            CustDimension.Add('Posted Sal Invoice ACH Payment status', 'Disabled');

                        FeautureTelemetry.LogUptake('EVT000210', 'Posted Sales Invoice ACH Payments', FeatureUptakeStatus::"Set up", false, CustDimension);
                    end;
                }
                field("Enable CCPayment Sales Orders"; Rec."Enable CCPayment Sales Orders")
                {
                    ApplicationArea = ALL;
                    Caption = 'Enable CC Payments for Sales Orders';

                    trigger OnValidate()
                    begin
                        Clear(CustDimension);
                        if Rec."Enable CCPayment Sales Orders" then
                            CustDimension.Add('Sales Order CC Payment status', 'Enabled')
                        else
                            CustDimension.Add('Sales Order CC Payment status', 'Disabled');

                        FeautureTelemetry.LogUptake('EVT000230', 'Sales Order CC Payments', FeatureUptakeStatus::"Set up", false, CustDimension);
                    end;
                }
                field("Enable ACHPayment Sales Orders"; Rec."Enable ACHPayment Sales Orders")
                {
                    ApplicationArea = ALL;
                    Caption = 'Enable ACH Payments for Sales Orders';

                    trigger OnValidate()
                    begin
                        Clear(CustDimension);
                        if Rec."Enable ACHPayment Sales Orders" then
                            CustDimension.Add('Sales Order ACH Payment status', 'Enabled')
                        else
                            CustDimension.Add('Sales Order ACH Payment status', 'Disabled');

                        FeautureTelemetry.LogUptake('EVT000250', 'Sales Order ACH Payments', FeatureUptakeStatus::"Set up", false, CustDimension);
                    end;
                }
            }

        }

    }

    trigger OnOpenPage()
    begin
        FeautureTelemetry.LogUptake('EVT000260', 'Payment Setup', FeatureUptakeStatus::Discovered, False, CustDimension);
        // FeautureTelemetry.LogUptake('EVT000130', 'Posted Sales Invoice ACH Payments', FeatureUptakeStatus::Discovered, False, CustDimension);
        // FeautureTelemetry.LogUptake('EVT000150', 'Sales Order CC Payments', FeatureUptakeStatus::Discovered, False, CustDimension);
        // FeautureTelemetry.LogUptake('EVT000170', 'Sales Order ACH Payments', FeatureUptakeStatus::Discovered, False, CustDimension);

    end;

    var
        FeautureTelemetry: Codeunit "Feature Telemetry";
        FeatureUptakeStatus: Enum "Feature Uptake Status";
        CustDimension: Dictionary of [Text, Text];
}
