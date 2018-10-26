table 50100 "CRFSetupCRF"
{
    DataClassification = ToBeClassified;
    Caption = 'CRF Setup';

    fields
    {
        field(1; "Primary Key"; code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Key';
        }
        field(2; Username; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Username';
        }
        field(3; Password; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Password';
        }
        field(4; "Token URL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Token URL';
        }
        field(5; "Register Invoice URL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Register Invoice URL';
        }
        field(6; "Get Invoice URL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Get Invoice URL';
        }
        field(7; "Cancel Invoice URL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cancel Invoice URL';
        }
        field(8; "Token Parser Query"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Token Parser Query';
        }
        field(9; "Register Invoice Parser Query"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Register Invoice Parser Query';
        }
        field(10; "Get Invoice Parser Query"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Get Invoice Parser Query';
        }
        field(11; "Cancel Invoice Parser Query"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cancel Invoice Parser Query';
        }
        field(12; Enabled; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enabled';
        }
        field(13; "Log Web Requests"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Log Web Requests';
        }
        field(14; "Ping URL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ping URL';
        }
        field(15; "Ping Parser Query"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ping Parser Query';
        }
        field(16; "Automatic Sending to CRF"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Automatic Sending to CRF';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}