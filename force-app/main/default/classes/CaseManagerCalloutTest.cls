@IsTest
private class CaseManagerCalloutTest {
    @IsTest static void caseCalloutTest(){
        // Set mock callout class
        Test.setMock(HttpCalloutMock.class,new CaseManagerCalloutMock());
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse response = CaseManagerCallout.caseCallout();
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType =='application/json');
        // verify mock response is not null
        System.assertNotEquals(null,response,'The callout returned a null response');
        // verify status code
        System.assertEquals(200,response.getStatusCode(),'The status code is not 200');
        //verify the array contains 3 items
        List<Case> results = (List<Case>) System.JSON.deserialize(response.getBody(),List<Case>.class);
        System.assertEquals(3, results.size(),'The array should only contain 3 items.'); 
        System.debug(response.getBody());
        System.debug(results);
    }
}