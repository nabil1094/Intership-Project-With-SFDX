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
        
    },
    getListCase : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Case Number', fieldName: 'CaseNumber', type: 'text',sortable: true},
            {label: 'Subject', fieldName: 'Subject', type: 'text',sortable: true},
            {label: 'Status', fieldName: 'Status', type: 'text', sortable: true},
            {label: 'Origin', fieldName: 'Origin', type: 'text',sortable: true},
            {label: 'Priority', fieldName: 'Priority', type: 'text',sortable: true},
            {label: 'Date Closed', fieldName: 'ClosedDate__c', type: 'text',sortable: true},
            {label: 'Date Created', fieldName: 'CreatedDate__c', type: 'text',sortable: true},
            {label: 'View', type: 'button', initialWidth: 135, typeAttributes: { label: 'View Details', name: 'view_details', title: 'Click to View Details'}}
            
        ]);
        var params = event.getParam("arguments");
        if(params){
            var param1 = params.allCaseList;
            var param2 = params.isListEmpty;
        }
        
        component.set("v.allCases",param1);
        
        if (param1.length > 0){
            component.set("v.emptyList",true);
            component.set("v.entryAtt" , true);
        }
        else{
            component.set("v.emptyList",false);
            component.set("v.entryAtt" , false);
        }
        
        helper.filter(component);
        
    },
    sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.filteredCase");
        var reverse = sortDirection !== 'asc';
        data.sort(this.sortBy(fieldName, reverse))
        cmp.set("v.filteredCase", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
        function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },
    showRowDetails : function(row) {
        
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": row.Id,
            "slideDevName": "related"
        });
        navEvt.fire();
    },
    updateColumnSorting: function (component, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        component.set("v.sortedBy", fieldName);
        component.set("v.sortedDirection", sortDirection);
        helper.sortData(component, fieldName, sortDirection);
    },
    handleRowAction: function (component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'view_details':
                helper.showRowDetails(row);
                break;
            case 'edit_status':
                helper.editRowStatus(component, row, action);
                break;
            default:
                helper.showRowDetails(row);
                break;
        }
    }
})