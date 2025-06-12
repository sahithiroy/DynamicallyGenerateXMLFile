public class LeadNotifier {
    @future(callout=true)
    public static void notifyExternalSystem(String email){
        HttpRequest req =new HttpRequest();
        req.setEndpoint('https://api.external.com/notify');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"email": "' + email + '"}');
        Http http=new Http();
        HttpResponse res = http.send(req);        
    }
}