public class CaseManagerController {
    @AuraEnabled
    public static List<Case> caseCallout(String StatusFilter, String PriorityFilter, String OriginFilter){
        String sta = StatusFilter;
        String prio = PriorityFilter;
        String ori = OriginFilter;
        HttpRequest request = new HttpRequest();       
        String endUrl = 'callout:CaseCalloutNC/services/apexrest/displayCases/?Status='+sta+'&&Priority='+prio+'&&Origin='+ori+'';
        request.setMethod('GET');
        request.setHeader('Content-Type','application/json');
        request.setEndpoint(endUrl);
        Http http = new Http();
        
        HttpResponse response = http.send(request);
        System.debug('StatusCODE>>>>>>>' + response.getStatusCode());
        //String listthesecases;
        List<Case> listCase = new List<Case>();
        if (response.getStatusCode() == 200){
          /*  String response1 = response.getBody();
            System.debug('RESPONSE 1>>'+response1);
            //List<Object> caseList = new List<Object>();
            //Map<String,Case> caselist = (Map<String,Case>) JSON.deserialize(response1,Map<String,Case>.class); 
            listthesecases = (String) JSON.deserialize(response1,String.class);
            //Map<String, Object> listthesecases = (Map<String, Object>) JSON.deserializeUntyped(listthesecases);
            System.debug('listthecases>>>>>>>>>>>'+listthesecases);
            //List<Object> eachCases = (List<Object>) listthesecases.get('attributes');
            */
            listCase = (List<Case>)JSON.deserialize(response.getBody(),List<Case>.class);
            System.debug('Before we cast it'+ response.getBody());
        }      
            System.debug('This is working'+listCase);
        return listCase;
    }
}