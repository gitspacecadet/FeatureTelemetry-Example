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
                var
                    CustDimension: Dictionary of [Text, Text];
                    FeautureTelemetry: Codeunit "Feature Telemetry";
                    FeatureUptakeStatus: Enum "Feature Uptake Status";
                begin
                    Clear(CustDimension);
                    if PostedSalInv then begin
                        FeatureNameCaption := 'Posted Sales Invoice ACH Payments';
                        LogUpateEventID := 'EVT000140';
                    end
                    else begin
                        FeatureNameCaption := 'Sales Order ACH Payments';
                        LogUpateEventID := 'EVT000180';
                    end;

                    FeautureTelemetry.LogUptake(LogUpateEventID, FeatureNameCaption, FeatureUptakeStatus::Used, False, CustDimension);

                    if (PaymentAmount < 1) or (PaymentAmount > OriginalPaymentAmount) then begin
                        if PostedSalInv then
                            EventID := 'EVT000040'
                        else
                            EventID := 'EVT000080';

                        CustDimension.Add('NewOrExistingCard', 'New');
                        FeautureTelemetry.LogError(EventID, FeatureNameCaption, 'Creating Payment', 'Incorrect Amount', GetLastErrorCallStack, CustDimension);
                        Error(PaymentAmountError);
                    end
                    else begin
                        if PostedSalInv then
                            EventID := 'EVT000030'
                        else
                            EventID := 'EVT000070';

                        CustDimension.Add('NewOrExistingCard', 'Existing');

                        FeautureTelemetry.LogUsage(EventID, FeatureNameCaption, 'Payment Created', CustDimension);
                    end;

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

        PostedSalInv: Boolean;
        FeatureNameCaption: Text;
        EventID: Text;
        LogUpateEventID: Text;

    procedure SetParameters(InvNo: Code[20])
    // Sets the default parameters for the page
    begin
        PstSalesInvoice.Get(InvNo);
        PostedSalInv := true;
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