public class CaseManagerCallout{
    @AuraEnabled
    public static List<Object> getValuesFromComponent(String StatusFilter,String PriorityFilter,String OriginFilter){
        String StatusValue = StatusFilter;
        String PriorityValue = PriorityFilter;
        String OriginValue = OriginFilter;
        return CaseManagerController.caseCallout(StatusValue,PriorityValue,OriginValue);
    }
}