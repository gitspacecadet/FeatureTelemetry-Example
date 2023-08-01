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

                field(EnableCCPaymentsPostedSal; EnableCCPaymentsPostedSal)
                {
                    ApplicationArea = ALL;
                    Caption = 'Enable CC Payments for Posted Sales Invoices';

                    trigger OnValidate()
                    begin
                        Clear(CustDimension);
                        if EnableCCPaymentsPostedSal then
                            CustDimension.Add('Posted Sal Invoice CC Payment status', 'Enabled')
                        else
                            CustDimension.Add('Posted Sal Invoice CC Payment status', 'Disabled');

                        FeautureTelemetry.LogUptake('EVT000190', 'Posted Sales Invoice CC Payments', FeatureUptakeStatus::Used, false, CustDimension);
                    end;
                }
                field(EnableACHPaymentsPostedSal; EnableACHPaymentsPostedSal)
                {
                    ApplicationArea = ALL;
                    Caption = 'Enable ACH Payments for Posted Sales Invoices';

                    trigger OnValidate()
                    begin
                        Clear(CustDimension);
                        if EnableACHPaymentsPostedSal then
                            CustDimension.Add('Posted Sal Invoice ACH Payment status', 'Enabled')
                        else
                            CustDimension.Add('Posted Sal Invoice ACH Payment status', 'Disabled');

                        FeautureTelemetry.LogUptake('EVT000210', 'Posted Sales Invoice ACH Payments', FeatureUptakeStatus::Used, false, CustDimension);
                    end;
                }
                field(EnableCCPaymentsForSales; EnableCCPaymentsForSales)
                {
                    ApplicationArea = ALL;
                    Caption = 'Enable CC Payments for Sales Orders';

                    trigger OnValidate()
                    begin
                        Clear(CustDimension);
                        if EnableCCPaymentsForSales then
                            CustDimension.Add('Sales Order CC Payment status', 'Enabled')
                        else
                            CustDimension.Add('Sales Order CC Payment status', 'Disabled');

                        FeautureTelemetry.LogUptake('EVT000230', 'Sales Order CC Payments', FeatureUptakeStatus::Used, false, CustDimension);
                    end;
                }
                field(EnableACHPaymentsForSales; EnableACHPaymentsForSales)
                {
                    ApplicationArea = ALL;
                    Caption = 'Enable ACH Payments for Sales Orders';

                    trigger OnValidate()
                    begin
                        Clear(CustDimension);
                        if EnableACHPaymentsForSales then
                            CustDimension.Add('Sales Order ACH Payment status', 'Enabled')
                        else
                            CustDimension.Add('Sales Order ACH Payment status', 'Disabled');

                        FeautureTelemetry.LogUptake('EVT000250', 'Sales Order ACH Payments', FeatureUptakeStatus::Used, false, CustDimension);
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
        EnableCCPaymentsPostedSal, EnableACHPaymentsForSales, EnableACHPaymentsPostedSal, EnableCCPaymentsForSales : Boolean;
        FeautureTelemetry: Codeunit "Feature Telemetry";
        FeatureUptakeStatus: Enum "Feature Uptake Status";
        CustDimension: Dictionary of [Text, Text];
}
