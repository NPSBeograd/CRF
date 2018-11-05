pageextension 50104 "PostPurchInvExtCRF" extends "Posted Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field("CRF Invoice ID "; "CRF Invoice ID ")
            {
                ApplicationArea = All;
            }
        }
    }
}