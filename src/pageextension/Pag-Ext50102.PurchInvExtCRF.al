pageextension 50102 "PurchInvExtCRF" extends "Purchase Invoice"
{
    layout
    {
        addafter("Job Queue Status")
        {
            field("CRF Invoice ID"; "CRF Invoice ID")
            {
                ApplicationArea = All;
            }
        }
    }
}