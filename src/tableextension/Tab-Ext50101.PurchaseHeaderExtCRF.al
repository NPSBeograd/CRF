tableextension 50101 "PurchaseHeaderExtCRF" extends "Purchase Header"
{
    fields
    {
        field(50100; "CRF Invoice ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'CRF Invoice ID';
        }
    }
}