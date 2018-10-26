pageextension 50100 "CustomerCardExtCRF" extends "Customer Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field(JBKJS; JBKJS)
            {
                ApplicationArea = All;
            }
        }
    }
}