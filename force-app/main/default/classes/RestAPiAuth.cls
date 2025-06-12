public class RestAPiAuth {
    public static void getAccountRecords(){
        HttpRequest accountRequest = new HttpRequest();
        String query = 'SELECT FIELDS(All) FROM Account ORDER BY Name LIMIT 5';
        accountRequest.setEndpoint('https://zyroneenergy-dev-ed.develop.my.salesforce.com/services/data/v62.0/query/?q=' + EncodingUtil.urlEncode(query, 'UTF-8'));
        accountRequest.setMethod('GET');
        accountRequest.setHeader('Authorization','Bearer '+'00DdL000002UWVx!AQEAQIOqKj4o6cXJwu1eLReHq4iPhtXDrIsknIrHFqLFfBnTxfoJGSIukmdKOmJK3KsM3Xartu1mJKW6LYKAlpEwGW4KwYFR');
        accountRequest.setTimeout(120000);

        Http accountHttp = new Http();
        HttpResponse accountResponse = accountHttp.send(accountRequest);

        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(accountResponse.getBody());
        List<Object> records = (List<Object>) result.get('records');

        System.debug('Records: ' + records);
    }
    public static void getAccountAuth(){
        
    }
}