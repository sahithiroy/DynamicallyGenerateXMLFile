global class AnimalLocatorMock implements HttpCalloutMock {
        global HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"animal":{"id":1,"name":"Tiger","eats":"meat","says":"roar"}}');
            res.setStatusCode(200);
            return res;
        }
    }