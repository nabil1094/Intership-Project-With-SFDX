({
    filter : function(component) {
        if (component.get("v.searchText")){
            let goodStuff = _.filter(component.get("v.allCases"), function(record){
                let contains = false;
                _.forEach(record, function(value){
                    contains = contains || _.includes(_.lowerCase(_.toString(value)), _.lowerCase(component.get("v.searchText")));
                });
                return contains;
            });
            component.set("v.filteredCase", goodStuff);
        } else {
            //no searchText...just dump them in
            component.set("v.filteredCase", component.get("v.allCases"));
        }
    },
    
    doInit : function(component, event, helper) {
        //get the product list
       /* let action = component.get("c.getListCase");
        console.log('1a');
        action.setCallback(this, function(a){
            let state = a.getState();
            if (state === "SUCCESS") {
                let cas = JSON.parse(a.getReturnValue());
                console.log(cas);
                component.set("v.allCases", cas);
                helper.filter(component);
            } else if (state === "ERROR") {
                console.log(a.getError());
            }
        });
        console.log('3a');
        $A.enqueueAction(action);*/
    },
    getListCase : function(component, event, helper) {
        var params = event.getParam("arguments");
        if(params){
            var param1 = params.allCaseList;
            var param2 = params.isListEmpty;
        }
        //console
        component.set("v.allCases",param1);
        component.set("v.emptyList",param2);
        helper.filter(component);
    }
})