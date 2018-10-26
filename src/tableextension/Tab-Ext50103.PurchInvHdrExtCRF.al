tableextension 50103 "PurchInvHdrExtCRF" extends "Purch. Inv. Header"
{
    fields
    {
        field(50100; "CRF Invoice ID "; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'CRF Invoice ID';
        }
    }
}