codeunit 50100 "CRF Integration"
{
    trigger OnRun()
    begin
        CRFSetup.Get();
    end;

    local procedure InitRequest(UrlParam: Text; Method: Text; RequestOptionParam: Option GetToken,RegisterInvocie,GetInvoice,CancelInvoice,Ping)
    var
        RequestBodyJson: Text;
        HttpClientVarLoc: HttpClient;
        VendLoc: Record Vendor;
        CRFInvLoc: Code[20];
    begin
        CRFSetup.Get();
        if not (RequestOptionParam in [RequestOptionParam::Ping, RequestOptionParam::GetToken]) then
            CRFSetup.TestField(Enabled);
        HttpClientVarLoc.DefaultRequestHeaders().Add('User-Agent', 'Dynamics 365');
        case RequestOptionParam of
            RequestOptionParam::GetToken:
                begin
                    SetTokenRequest(RequestBodyJson);
                    HttpContentVar.WriteFrom(RequestBodyJson);
                    HttpContentVar.GetHeaders(HttpHeadersVar);
                    HttpHeadersVar.Remove('Content-Type');
                    HttpHeadersVar.Add('Content-Type', 'application/json');
                    HttpHeadersVar.Add('SOAPAction', '');
                    HttpContentVar.GetHeaders(HttpHeadersVar);

                    if not HttpClientVarLoc.Post(UrlParam, HttpContentVar, ResponseMessage) then begin
                        ResponseMessage.Content().ReadAs(JsonText);
                        Error(GetTokenErr + '\' + JsonText);
                    end;
                    ResponseMessage.Content().ReadAs(JsonText);
                    JsonTokenVar.ReadFrom(JsonText);
                    JsonObjectVar := JsonTokenVar.AsObject();
                    if not JsonObjectVar.SelectToken(CRFSetup."Token Parser Query", JsonTokenVar) then
                        AccessToken := '';
                    if not JsonTokenVar.AsValue().IsNull() then
                        AccessToken := '';
                    AccessToken := JsonTokenVar.AsValue().AsText();
                end;
            RequestOptionParam::GetInvoice:
                begin
                    HttpClientVarLoc.DefaultRequestHeaders().Add('User-Agent', 'Dynamics 365');
                    HttpClientVarLoc.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + AccessToken);
                    if not HttpClientVarLoc.Get(UrlParam, ResponseMessage) then
                        Error(GetInvoiceErr);
                    ResponseMessage.Content().ReadAs(JsonText);
                    JsonTokenVar.ReadFrom(JsonText);
                    JsonObjectVar := JsonTokenVar.AsObject();
                    VendLoc.SetRange("VAT Registration No.", SelelctJsonToken(JsonObjectVar, StrSubstNo(CRFSetup."Get Invoice Parser Query", 'creditorTaxIdNumber')));
                    //VendLoc.SetRange("Registration No. 2",SelelctJsonToken(JsonObjectVar,StrSubstNo(CRFSetup."Get Invoice Parser Query",'creditorCompanyNumber')));
                    if VendLoc.FindFirst() then
                        Error(VendErr,SelelctJsonToken(JsonObjectVar, StrSubstNo(CRFSetup."Get Invoice Parser Query", 'creditorTaxIdNumber')));
                    CRFInvLoc := SelelctJsonToken(JsonObjectVar, StrSubstNo(CRFSetup."Get Invoice Parser Query", 'invoiceId'));
                end;
        end;
    end;

    local procedure GetInvoice(CRFInvNo: Code[20]; CheckCRFSetup: Boolean)
    var
        VendLoc: Record Vendor;
    begin
        if CRFInvNo = '' then
            Error(CRFNoErr);
        CRFSetup.Get();
        if NotificationInfo.Recall() then;
        if not CRFSetup.Enabled then
            CRFSetup.TestField(Enabled);
        InitRequest(StrSubstNo(CRFSetup."Get Invoice URL", CRFInvNo), 'GET', RequestOptions::GetInvoice);
    end;

    local procedure SetTokenRequest(var RequestBodyJson: Text)
    var
        JObjectLoc: JsonObject;
    begin
        JObjectLoc.Add('login', CRFSetup.Username);
        JObjectLoc.Add('password', CRFSetup.Password);
        JObjectLoc.WriteTo(RequestBodyJson);
    end;

    local procedure SelelctJsonToken(JsonObjectParam: JsonObject; Path: Text): Text
    var
        JsonTokenLoc: JsonToken;
    begin
        if not JsonObjectParam.SelectToken(Path, JsonTokenLoc) then
            exit('');
        if not JsonTokenLoc.AsValue().IsNull() then
            exit('');
        exit(JsonTokenLoc.AsValue().AsText());
    end;

    local procedure GetAccessToken()
    var
        myInt: Integer;
    begin
        if not CRFSetup.Enabled then
            exit;
        AccessToken := '';
        InitRequest(CRFSetup."Token URL", 'POST', RequestOptions::GetToken);
    end;

    var
        CRFSetup: Record "CRF Setup";
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        HttpContentVar: HttpContent;
        HttpHeadersVar: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        InStr: InStream;
        JsonText: Text;
        JsonTokenVar: JsonToken;
        JsonObjectVar: JsonObject;
        AccessToken: Text;
        NotificationInfo: Notification;
        RequestOptions: Option GetToken,RegisterInvoice,GetInvoice,CancelInvoice,Ping;
        TokenErr: Label 'Error while getting a token.';
        SentInoviceInfo: Label 'Invoice %1 was successfully sent to the CRF.';
        CRFNoErr: Label 'CRF Invoice No must not be empty.';
        GetInvoiceErr: Label 'Getting Invoice Error';
        GetTokenErr: Label 'Getting Token Error';
        VendErr: Label 'There is no vendor with VAT Registration %1';
}