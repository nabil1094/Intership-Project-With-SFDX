({  
    onDateTypeSelect: function(component,event,helper){
    var selectCmp = component.find("DateType");
    var val = selectCmp.get("v.value");
    console.log("val >>>   " + val);
    component.set("v.showDate", true);
    if (val == "CreatedDate" ){
        component.set("v.isDate",false);
        console.log("isDate >>>   " + component.get("v.isDate"));
    }
    else if (val == "ClosedDate") {
        component.set("v.isDate", true);
    }

},
  onStatusSelect: function(component,event,helper) {
      var selectCmp = component.find("InputStatus");
      var val = selectCmp.get("v.value");
      component.set("v.StatusFilter", val);
      console.log("Status >>>   " + component.get("v.StatusFilter"));
  },
  onOriginSelect: function(component,event,helper){
      var selectCmp = component.find("InputOrigin");
      var val = selectCmp.get("v.value");
      component.set("v.OriginFilter", val);
      console.log("Origin >>>   " + component.get("v.OriginFilter"));
  },
  onPrioritySelect: function(component,event,helper){
      var selectCmp = component.find("InputPriority");
      var val = selectCmp.get("v.value");
      component.set("v.PriorityFilter", val);
      console.log("Priority >>>   " + component.get("v.PriorityFilter"));
  },
  /* Added On Date Select Function */
  onDateSelect: function(component,event,helper) {
      if (component.get("v.isDate") == true){
          
          var selectCmp1 = component.find("ClosedDateFromInputDate");
          var val1 = selectCmp1.get("v.value");
          component.set("v.DateFromClosedDate", val1);
          console.log("ClosedDateFrom >>>   " + component.get("v.DateFromClosedDate"));
          
          var selectCmp2 = component.find("ClosedDateToInputDate");
          var val2 = selectCmp2.get("v.value");
          component.set("v.DateToClosedDate", val2);
          console.log("ClosedDateTo >>>   " + component.get("v.DateToClosedDate"));   
      }
      else if( component.get("v.isDate") == false){
          var selectCmp3 = component.find("CreatedDateFromInputDate");
          var val3 = selectCmp3.get("v.value");
          component.set("v.DateFromCreatedDate", val3);
          console.log("CreatedDateFrom >>>   " + component.get("v.DateFromCreatedDate"));
          
          var selectCmp4 = component.find("CreatedDateToInputDate");
          var val4 = selectCmp4.get("v.value");
          component.set("v.DateToCreatedDate", val4);
          console.log("CreatedDateTo >>>   " + component.get("v.DateToCreatedDate"));
      }
      
  },
  
  handleClick: function(component,event,helper){
      if(component.get("v.StatusFilter") != "" || component.get("v.OriginFilter") != "" || component.get("v.PriorityFilter") != "") {
          var action = component.get("c.caseCallout");
          var sta =component.get("v.StatusFilter");
          var prio = component.get("v.PriorityFilter");
          var ori =component.get("v.OriginFilter");
          
          /* Added vars for Date Fields */
          var closedatefrom = component.get("v.DateFromClosedDate");
          var closeddateto = component.get("v.DateToClosedDate");
          var createddatefrom = component.get("v.DateFromCreatedDate");
          var createddateto = component.get("v.DateToCreatedDate");
          
          action.setParams({ 
              StatusFilter : sta,
              PriorityFilter : prio,
              OriginFilter : ori,
              /* added params for date */
              ClosedDateFromFilter : closedatefrom,
              ClosedDateToFilter : closeddateto,
              OpenedDateFromFilter : createddatefrom,
              OpenedDateToFilter : createddateto,
          });
          action.setCallback(this, function(response) {
              var state = response.getState();
              //console.log(state);
              if (state === "SUCCESS") {
                  component.set("v.ListOfCase",response.getReturnValue());
                  //console.log(response.getReturnValue());
                  console.log("JSON >>>>>>>>>>>>>>" + JSON.stringify(response.getReturnValue()));
                  //Calling aura Method
                  var checkList = component.get("v.ListOfCase");
                  if(checkList.length > 0){
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
      else {
          // will not work in app
          /*
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Success!",
                "message": "The record has been updated successfully."
            });
            toastEvent.fire();
            */
          // Using custom toast
          component.set('v.showToast',true);
          component.set('v.toastMsg','Please select at least 1 filter.');
      }
  },
  
  closeToast: function(cmp, event, helper) {
      cmp.set('v.showToast',false);
      cmp.set('v.toastMsg','');
  }
  
 })