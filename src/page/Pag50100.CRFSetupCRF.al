page 50100 "CRFSetupCRF"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = CRFSetupCRF;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Username; Username)
                {
                    ApplicationArea = All;
                }
                field(Password; Password)
                {
                    ApplicationArea = All;
                }
                field(Enabled; Enabled)
                {
                    ApplicationArea = All;
                }
                field(ShowEnableWarning; ShowEnableWarning)
                {
                    ApplicationArea = All;
                }
            }
            group(ServiceFunctions)
            {
                Caption = 'Service Functions';
                field("Ping URL"; "Ping URL")
                {
                    ApplicationArea = All;
                }
                field("Token URL"; "Token URL")
                {
                    ApplicationArea = All;
                }
                field("Register Invoice URL"; "Register Invoice URL")
                {
                    ApplicationArea = All;
                }
                field("Get Invoice URL"; "Get Invoice URL")
                {
                    ApplicationArea = All;
                }
                field("Cancel Invoice URL"; "Cancel Invoice URL")
                {
                    ApplicationArea = All;
                }
            }
            group(ParsingResponses)
            {
                Caption = 'Parsing Responses';
                field("Token Parser Query"; "Token Parser Query")
                {
                    ApplicationArea = All;
                }
                field("Register Invoice Parser Query"; "Register Invoice Parser Query")
                {
                    ApplicationArea = All;
                }
                field("Get Invoice Parser Query"; "Get Invoice Parser Query")
                {
                    ApplicationArea = All;
                }
                field("Cancel Invoice Parser Query"; "Cancel Invoice Parser Query")
                {
                    ApplicationArea = All;
                }
                field("Ping Parser Query"; "Ping Parser Query")
                {
                    ApplicationArea = All;
                }
            }
            group(AdditionalSettings)
            {
                Caption = 'Additional Settings';
                field("Automatic Sending to CRF"; "Automatic Sending to CRF")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SetURLsToDefault)
            {
                Caption = 'Set URLs to Default';
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
            action(TestConnection)
            {
                Caption = 'Test Connection';
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
            action(CRFImportJBKJS)
            {
                Caption = 'Import JBKJS';
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    local procedure UpdateBasedOnEnable()
    begin
        EditableByNotEnabled := not Enabled;
        ShowEnableWarning := '';
        if CurrPage.Editable() and Enabled then
            ShowEnableWarning := EnabledWarningTok;
    end;

    local procedure UpdateEncryptedField(InputGUID: Guid; var Text: text[50])
    begin
        if IsNullGuid(InputGUID) then
            Text := ''
        else
            Text := '*************';
    end;

    local procedure CheckEncryption()
    begin
        if not CheckedEncryption and not EncryptionEnabled() then begin
            CheckedEncryption := true;
            if Confirm(EncryptionIsNotActivatedQst) then begin
                Page.Run(page::"Data Encryption Management");
                CheckedEncryption := false;
            end;
        end;
    end;

    local procedure DrilldownCode()
    begin
        if Confirm(DisableEnableQst, true) then begin
            Enabled := false;
            UpdateBasedOnEnable();
            CurrPage.Update();
        end;

    end;

    var
        CheckedEncryption: Boolean;
        EditableByNotEnabled: Boolean;
        ShowEnableWarning: Text;
        EncryptionIsNotActivatedQst: Label 'Data encryption is not activated. It is recommended that you encrypt data. \Do you want to open the Data Encryption Management window?';
        EnabledWarningTok: Label 'You must disable the service before you can make changes.';
        DisableEnableQst: Label 'Do you want to disable the document exchange service?';
        EnableServiceQst: Label 'The %1 is not enabled. Are you sure you want to exit?';


}