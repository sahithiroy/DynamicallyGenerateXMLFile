@isTest
global class ParkServiceMock implements WebServiceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> responseMap,
        String endpoint,
        String soapAction,
        String requestName,
        String responseName,
        String responseNamespace,
        String clientId 
    ) {
        ParkService.byCountryResponse response = new ParkService.byCountryResponse();
        response.return_x = new String[] { 'Yosemite', 'Yellowstone' };
        responseMap.put('response_x', response);
    }
}