/* Author: Nabil Lallmahomed & Hashim Alleemudder
 * Apex Class: CaseManagerController - has only one method.
 * Class to set headers using REST API and Get method.
 */

public class CaseManagerController {
    
    /* Author: Nabil Lallmahomed & Hashim Alleemudder
     * This method returns a list of Cases based on the parameters set from the endpoint from CaseManagerController class.
     * This method takes 7 parameters of type String.
     */
    
    @AuraEnabled
    public static List<Case> caseCallout(String StatusFilter,
                                         String PriorityFilter,
                                         String OriginFilter,
                                         String ClosedDateFromFilter,
                                         String ClosedDateToFilter,
                                         String OpenedDateFromFilter,
                                         String OpenedDateToFilter){
    
        String sta = StatusFilter;
        String prio = PriorityFilter;
        String ori = OriginFilter;
        String closedafro = ClosedDateFromFilter;
        String closedato = ClosedDateToFilter;
        String openeddafro = OpenedDateFromFilter;
        String openedato = OpenedDateToFilter;
                                             
        System.debug('This is the field we are looking for' + closedafro);
                                             
        HttpRequest request = new HttpRequest();
        String endUrl = 'callout:CaseCalloutNC/services/apexrest/displayCases/?Status='+sta+
            			'&&Priority='+prio+
            			'&&Origin='+ori+
            			'&&DateClosedFrom='+closedafro+
            			'&&DateClosedTo='+closedato+
            			'&&DateOpenedFrom='+openeddafro+
            			'&&DateOpenedTo='+openedato+'';
        
        request.setMethod('GET');
        request.setHeader('Content-Type','application/json');
        request.setEndpoint(endUrl);
        Http http = new Http();
        HttpResponse response = http.send(request);
                                             
        System.debug('Status CODE is >>>>>>>' + response.getStatusCode());
        
        List<Case> listCase = new List<Case>();
        if (response.getStatusCode() == 200){

            listCase = (List<Case>)JSON.deserialize(response.getBody(),List<Case>.class);
            System.debug('Before deserializing the response'+ response.getBody());
        }      
        System.debug('List of cases>>>> ' + listCase);
        return listCase;
    }
}