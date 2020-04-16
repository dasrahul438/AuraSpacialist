({
  navToRecord: function(component, event, helper) {
    var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
      recordId: component.get("v.property.Id")
    });
    navEvt.fire();
  },
  editRecord:function(component, event, helper) {
    helper.showHide(component);
//     var editRecordEvent = $A.get("e.force:editRecord");
//     editRecordEvent.setParams({
//         recordId: component.get("v.property.Id")
//    });
//     editRecordEvent.fire();
  },

  handleSuccess:function(component, event, helper){
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": "Success!",
        "message": "The property record has been updated successfully.",
        "type":"success"
    });
    toastEvent.fire();

    //record update event--> after successfully updated the record it will refresh autometically
    var recUpdate = $A.get("e.c:recordUpdated");
    
    recUpdate.setParams({
        //set the params
    })
    recUpdate.fire(); 
    helper.showHide(component);
  },

  handleCancel:function(component, event, helper){
    helper.showHide(component);
    event.preventDefault();
  }
});
