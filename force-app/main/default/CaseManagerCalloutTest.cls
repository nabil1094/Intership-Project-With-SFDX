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
        //verify content type
        System.assertEquals('application/json;charset=UTF-8',
          result.getHeader('Content-Type'),
          'The content type value is not expected.');
        //verify the array contains 3 items
        Map<String, Object> results = (Map<String, Object>) 
            JSON.deserializeUntyped(result.getBody());
        List<Object> caseList = (List<Object>) results.get('attributes');
        System.assertEquals(3, caseList.size(),
          'The array should only contain 3 items.'); 
        



    }
}
