@RestResource(urlMapping='/displayCases/*')
global with sharing class CaseManager{
    @HttpGet
    //Changed List<Case> to String
    global static List<Case> getListCase(){
        HttpRequest res = new HttpRequest();
        
        String sta = RestContext.request.params.get('Status');
        String prio = RestContext.request.params.get('Priority');
        String ori = RestContext.request.params.get('Origin');
        
        List<Case> caseList = new List<Case>();
        
        System.debug('Results: >>>>>>>' + sta+'>>>>>>>'+prio+'>>>>>>'+ori);
        
        String query = 'SELECT Id,Status,Origin,Priority,'+
            		   'Subject,CaseNumber,Reason,ClosedDate,CreatedDate,Description,Type' +
                     	' FROM case WHERE Id != null ';        
        if(sta!='None') {
            query +='AND Status =\''+sta+'\'';
        }
        if(prio!='None') {
            query += ' AND Priority =\''+prio+'\'';
        }
        if(ori!='None') {
            query += ' AND Origin =\''+ori+'\'';
        }
        System.debug('Query is>>>>>>>>>>'+query);
        caseList = Database.query(query);
        System.debug('caselist is >>>>>' + caselist);
        String caseListSerialize = JSON.serialize(caseList);
        System.debug('Caselistserialized>>>>>'+caseListSerialize);
        System.debug('The number of cases' + caseList.size());
        return caseList;
        
        //String caseListSerialize = JSON.serialize(caseList);
        //System.debug(caseListSerialize);
        
        //query = 'SELECT+Id,Status,Origin,Priority+FROM+case+WHERE+Status=\''+sta+'\'+AND+Priority=\''+prio+'\'+AND+Origin=\''+ori+'\'';
        /*  String query = 'SELECT Id,Status,Origin,Priority FROM case WHERE Id != null ';        
if(String.IsNotBlank(sta)) {
query +='AND Status =\''+sta+'\'';
}
if(String.IsNotBlank(prio)) {
query += ' AND Priority =\''+prio+'\'';
}
if(String.IsNotBlank(ori)) {
query += ' AND Origin =\''+ori+'\'';
}
*/
        
    }
}