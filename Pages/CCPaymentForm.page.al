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
                var
                    CustDimension: Dictionary of [Text, Text];
                    FeautureTelemetry: Codeunit "Feature Telemetry";
                    FeatureUptakeStatus: Enum "Feature Uptake Status";
                begin
                    Clear(CustDimension);
                    if PostedSalInv then begin
                        FeatureNameCaption := 'Posted Sales Invoice CC Payments';
                        LogUpateEventID := 'EVT000120';

                    end
                    else begin
                        FeatureNameCaption := 'Sales Order CC Payments';
                        LogUpateEventID := 'EVT000160';
                    end;

                    FeautureTelemetry.LogUptake(LogUpateEventID, FeatureNameCaption, FeatureUptakeStatus::Used, False, CustDimension);

                    CustDimension.Add('NewOrExistingCard', 'New');

                    if (PaymentAmount < 1) or (PaymentAmount > OriginalPaymentAmount) then begin
                        if PostedSalInv then
                            EventID := 'EVT000020'
                        else
                            EventID := 'EVT000060';

                        FeautureTelemetry.LogError(EventID, FeatureNameCaption, 'Creating Payment', 'Incorrect Amount', PaymentAmountError, CustDimension);
                        Error(PaymentAmountError);
                    end
                    else begin
                        if PostedSalInv then
                            EventID := 'EVT000010'
                        else
                            EventID := 'EVT000050';

                        FeautureTelemetry.LogUsage(EventID, FeatureNameCaption, 'Payment Created', CustDimension);
                    end;

                end;
            }
        }
    }
    var

        PaymentAmountError: Label 'Payment Amount could not be more than invoice remaining amount or less than 1.';

        PstSalesInvoice: Record "Sales Invoice Header";

        PaymentAmount, OriginalPaymentAmount : Decimal;
        PostedSalInv: Boolean;
        FeatureNameCaption: Text;
        EventID: Text;
        LogUpateEventID: Text;


    trigger OnOpenPage()
    begin
        // Set Default values
        PaymentAmount := OriginalPaymentAmount;
    end;

    procedure SetParameters(InvoiceNo: code[20])
    // Sets the default parameters for the page
    begin
        PstSalesInvoice.get(InvoiceNo);
        PostedSalInv := true;
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