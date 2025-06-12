@isTest
private class AnimalLocatorTest {
    @isTest
    static void testGetAnimalNameByIdSuccess() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        Test.startTest();
        String result = AnimalLocator.getAnimalNameById(1);
        Test.stopTest();

        System.assertEquals('Tiger', result);
    }

    @isTest
    static void testGetAnimalNameByIdFailure() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorTest_FailureMock());

        Test.startTest();
        String result = AnimalLocator.getAnimalNameById(999);
        Test.stopTest();

        System.assertEquals(null, result);
    }

    class AnimalLocatorTest_FailureMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(404);
            res.setBody('Not Found');
            return res;
        }
        
    }
    
}