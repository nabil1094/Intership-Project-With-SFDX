@IsTest
private class CaseManagerTest{
@IsTest static void getListCaseTest(){
        List<Case> caseList = new List<Case>();
        // set up test request
        RestRequest request = new RestRequest();
        request.requestURI = 
        'https://weareinterns-dev-ed.my.salesforce.com/services/apexrest/displayCases';

        request.httpMethod = 'GET';
        RestContext.request = request;
        //Call the method to test
        List<Case> thisCase = CaseManager.getListCase();
        //verify results
        System.assert(thisCase!=null);
        System.assertEquals(50, thisCase.size());
    }

    // Helper method
    static void createTestRecord() {
        // Create 50 test Case record
        List<Case> caseTest = new List<Case>();
        for(Integer i=0;i<50;i++){
        caseTest.add(new Case(
            Subject='Test record '+i,
            Status='New',
            Origin='Phone',
            Priority='Medium'));
            }
        insert caseTest;
        } 

}