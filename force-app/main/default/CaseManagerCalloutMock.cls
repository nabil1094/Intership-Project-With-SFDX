@IsTest
global class CaseManagerCalloutMock implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();

        //Create test cases
        List<Case> caseTest = new List<Case>();
        for(Integer i=0;i<3;i++){
            caseTest.add(new Case(
                Subject='Test record '+i,
                Status='New',
                Origin='Phone',
                Priority='Medium'));
        }
        insert caseTest;
        //Converting Apex Object into JSON
        String caseTestJson = JSON.serialize(caseTest);
        //Parametrising the response
        response.setHeader('Content-Type','application/json');
        response.setBody(caseTestJson);
        response.setStatusCode(200);

        return response;
    }
}
