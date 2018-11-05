pageextension 50105 "PostSalesInvsExtCRF" extends "Posted Sales Invoices"
{
    layout
    {
        addlast(Control1)
        {
            field("CRF Document"; "CRF Document")
            {
                ApplicationArea = All;
            }
            field("Sent to CRF"; "Sent to CRF")
            {
                ApplicationArea = All;
            }
            field("CRF Invoice ID"; "CRF Invoice ID")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast(Invoice)
        {
            group(CRF)
            {
                Caption = 'Central Invoice Registry';
                action(CRFExport)
                {
                    Caption = 'CRF Export';
                }
                action(CRFRegisterInvoice)
                {
                    Caption = 'Register Invoice';
                }
                action(CRFCancelInvoice)
                {
                    Caption = 'Cancel Invoice';
                }
            }
        }
    }
}