/* Author: Nabil Lallmahomed & Hashim Alleemudder
 * Apex Class: CaseManager - has only one method.
 * Web Service class using REST API and HttpGet
 */

@RestResource(urlMapping='/displayCases/*')
global with sharing class CaseManager{
    
    /* Author: Nabil Lallmahomed & Hashim Alleemudder
     * This method returns a list of Cases based on the parameters 
     * set from the endpoint from CaseManagerController class.
     * This method takes no parameters.
     */
    
    @HttpGet
    global static List<Case> getListCase(){
        HttpRequest res = new HttpRequest();
        
        /* String values for Status/Priority/Origin and Dates parameters */
        String sta = RestContext.request.params.get('Status');
        String prio = RestContext.request.params.get('Priority');
        String ori = RestContext.request.params.get('Origin');
        String closedafro = RestContext.request.params.get('DateClosedFrom');
        String closedato = RestContext.request.params.get('DateClosedTo');
        String openeddafro = RestContext.request.params.get('DateOpenedFrom');
        String openedato = RestContext.request.params.get('DateOpenedTo');
       
        List<Case> caseList = new List<Case>();
        
        System.debug('Results: >>>>>>>' + sta+'>>>>>>>'+prio+'>>>>>>'+ori);
        
        /* Query to select Case depending on input parameters */
        String query = 'SELECT Id,Status,Origin,Priority,'+
            		   'Subject,CaseNumber,Reason,ClosedDate__c,CreatedDate__c,Description,Type' +
                     	' FROM Case WHERE Id != null ';
        if (String.isNotBlank(sta)) {
            query +='AND Status =\''+sta+'\'';
        }      
        if(String.isNotBlank(prio)) {
            query += ' AND Priority =\''+prio+'\'';
        }
        if(String.isNotBlank(ori)) {
            query += ' AND Origin =\''+ori+'\'';
        }
        if (String.isNotBlank(closedafro)){
              query += ' AND ClosedDate__c >=\''+closedafro+'\'';
        }
        if (String.isNotBlank(closedato)){
              query += ' AND ClosedDate__c <=\''+closedato+'\'';
        }
        if (String.isNotBlank(openeddafro)){
              query += ' AND CreatedDate__c >=\''+openeddafro+'\'';
        }
        if (String.isNotBlank(openedato)){
              query += ' AND CreatedDate__c <=\''+openedato+'\'';
        }
        System.debug('Query is>>>>>>>>>>'+query);
        caseList = Database.query(query);
        System.debug('caselist is >>>>>' + caselist);
        String caseListSerialize = JSON.serialize(caseList);
        System.debug('Caselistserialized>>>>>'+caseListSerialize);
        System.debug('The number of cases: ' + caseList.size());
        return caseList;
          
    }
}