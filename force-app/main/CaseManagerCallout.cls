public class CaseManagerCallout{
    public static HttpResponse caseCallout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(Label.ListOfCase);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful
        if(response.getStatusCode() == 200){
            System.debug('Response received');
            //Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(response.tostring());
        }
        else{
            System.debug('Failed' + response.getStatusCode());
        }
        return response;
    }
}