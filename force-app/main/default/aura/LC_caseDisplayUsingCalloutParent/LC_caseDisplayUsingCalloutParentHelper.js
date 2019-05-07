({
    onStatusSelect: function(component,event,helper) {
        var selectCmp = component.find("InputStatus");
        var resultCmp = component.find("statusResult");
        resultCmp.set("v.value", selectCmp.get("v.value"));
        var val = selectCmp.get("v.value");
        component.set("v.StatusFilter", val);
        console.log("Status >>>   " + component.get("v.StatusFilter"));
    },
    onOriginSelect: function(component,event,helper){
        var selectCmp = component.find("InputOrigin");
        var resultCmp = component.find("originResult");
        resultCmp.set("v.value", selectCmp.get("v.value"));
        var val = selectCmp.get("v.value");
        component.set("v.OriginFilter", val);
        console.log("Origin >>>   " + component.get("v.OriginFilter"));
    },
    onPrioritySelect: function(component,event,helper){
        var selectCmp = component.find("InputPriority");
        var resultCmp = component.find("priorityResult");
        resultCmp.set("v.value", selectCmp.get("v.value"));
        var val = selectCmp.get("v.value");
        component.set("v.PriorityFilter", val);
        console.log("Priority >>>   " + component.get("v.PriorityFilter"));
    },
    
    handleClick: function(component,event,helper){
        var action = component.get("c.caseCallout");
        var sta =component.get("v.StatusFilter");
        var prio = component.get("v.PriorityFilter");
        var ori =component.get("v.OriginFilter");
        action.setParams({ 
            StatusFilter : sta,
            PriorityFilter : prio,
            OriginFilter : ori
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log(state);
            if (state === "SUCCESS") {
                component.set("v.ListOfCase",response.getReturnValue());
                console.log(response.getReturnValue());
                //Calling aura Method
                var checkList = component.get("v.ListOfCase");
                if(checkList.length >0){
                    var childCmp = component.find("childComponent");
                    var allCases = component.get("v.ListOfCase");
                    var isTrue = true;
                    var returnCases = childCmp.listOfCases(allCases,isTrue);
                }
                else{
                    var childCmp = component.find("childComponent");
                    var allCases = component.get("v.ListOfCase");
                    var isTrue = false;
                    var returnCases = childCmp.listOfCases(allCases,isTrue);
                } 
            }
        });
        $A.enqueueAction(action);
        
    }
    
})