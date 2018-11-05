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
                        Error('Greska prilikom preuzimanja tokena\' + JsonText);
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
                        Error('Greska prilikom preuzimanja fakture');
                    ResponseMessage.Content().ReadAs(JsonText);
                    JsonTokenVar.ReadFrom(JsonText);
                    JsonObjectVar := JsonTokenVar.AsObject();
                    SelelctJsonToken(JsonObjectVar, StrSubstNo(CRFSetup."Get Invoice Parser Query", 'invoiceId'));
                end;
        end;
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


    var
        CRFSetup: Record "CRF Setup";
        HttpContentVar: HttpContent;
        HttpHeadersVar: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        JsonText: Text;
        JsonTokenVar: JsonToken;
        JsonObjectVar: JsonObject;
        AccessToken: Text;
}