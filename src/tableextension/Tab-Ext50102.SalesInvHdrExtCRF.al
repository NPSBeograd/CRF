tableextension 50102 "SalesInvHdrExtCRF" extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "Sent to CRF"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sent to CRF';
        }
        field(50101; "CRF Document"; Boolean)
        {
            Caption = 'CRF Document';
            FieldClass = FlowField;
            CalcFormula = exist (Customer where ("No." = field ("Sell-to Customer No."), JBKJS = filter (<> '')));

        }
        field(50102; "CRF Invoice ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'CRF Invoice ID';
        }
    }

}