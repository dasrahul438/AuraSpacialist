global class ProjectCalloutServiceMock implements HttpCalloutMock {
    
   global HttpResponse respond(HttpRequest req) {
        HttpResponse resp = new HttpResponse();
        resp.setHeader('Content-Type', 'application/json');
        resp.setStatusCode(201);
        resp.setStatus('OK');
        return resp;
    }
}