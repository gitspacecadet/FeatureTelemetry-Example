page 50103 "Payment Setup"
{
    SourceTable = "Sales & Receivables Setup";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            field(EnableCCPayments; EnableCCPayments)
            {
                ApplicationArea = ALL;
                Caption = 'Enable CC Payments';
            }
            field(EnableACHPayments; EnableACHPayments)
            {
                ApplicationArea = ALL;
                Caption = 'Enable ACH Payments';
            }
            field(EnableCCPaymentsForSales; EnableCCPaymentsForSales)
            {
                ApplicationArea = ALL;
                Caption = 'Enable CC Payments For Sales';
            }
            field(EnableACHPaymentsForSales; EnableACHPaymentsForSales)
            {
                ApplicationArea = ALL;
                Caption = 'Enable ACH Payments ForSales';
            }
        }
    }

    var
        EnableCCPayments, EnableACHPaymentsForSales, EnableACHPayments, EnableCCPaymentsForSales : Boolean;
}
