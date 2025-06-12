public class CalloutToSalesforceOrg {
    public static void getAccounts(){
        Http http=new Http();
        HttpRequest request =new HttpRequest();
        request.setEndpoint('callout:SFDCB/services/apexrest/accountmngt');
        request.setHeader('content-type','application/json ; charset=UTF-8');
        request.setHeader('Accept','application/json');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('response'+response);
        if (response.getStatusCode() == 200) {
            System.debug('Response Body: ' + response.getBody());
        } else {
            System.debug('Failed with status: ' + response.getStatus());
        }
    }

}