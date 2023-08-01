tableextension 50101 SalesRecSetup extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Enable CCPayments PostedSalInv"; Boolean)
        {
            Caption = 'Enable CC Payments for Posted Sales Invoices';
            DataClassification = CustomerContent;
        }
        field(50101; "Enable ACHPayment PostedSalInv"; Boolean)
        {
            Caption = 'Enable ACH Payments for Posted Sales Invoices';
            DataClassification = CustomerContent;
        }
        field(50102; "Enable CCPayment Sales Orders"; Boolean)
        {
            Caption = 'Enable CC Payments for Sales Orders';
            DataClassification = CustomerContent;
        }
        field(50103; "Enable ACHPayment Sales Orders"; Boolean)
        {
            Caption = 'Enable ACH Payments for Sales Orders';
            DataClassification = CustomerContent;
        }
    }
}
