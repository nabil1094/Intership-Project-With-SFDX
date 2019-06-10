@IsTest
private class CaseManagerControllerTest {
    @IsTest static void caseCalloutTest(){
        // Set mock callout class
        Test.setMock(HttpCalloutMock.class,new CaseManagerControllerMock());
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        List<Case> response = CaseManagerController.caseCallout('New','Medium','Phone');
        // verify mock response is not null
        System.assertNotEquals(null,response,'The callout returned a null response');
        //verify the array contains 3 items
        //List<Case> results = (List<Case>) System.JSON.deserialize(response.getBody(),List<Case>.class);
        //System.assertEquals(3, results.size(),'The array should only contain 3 items.'); 
        //System.debug(results);
    }
}