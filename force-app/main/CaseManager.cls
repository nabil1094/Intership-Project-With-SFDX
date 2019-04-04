@RestResource(urlMapping='/displayCases')
global with sharing class CaseManager{
    @HttpGet
    global static List<Case> getListCase(){
        List<Case> caseList = new List<Case>();
        caseList = [SELECT CaseNumber, Subject, Status, Origin, Priority
                    FROM Case 
                    LIMIT 50];
        System.debug('Results: ' + caseList);
        return caseList;

    }
}