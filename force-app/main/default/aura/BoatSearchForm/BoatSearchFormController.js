({
    initBoatSearchForm : function(component, event, helper) {
        var createRecordEvent = $A.get("e.force:createRecord");
        if (createRecordEvent){
            component.set("v.showNewButton", true);
        }
        
        helper.initBoatTypes(component);
    },
    createNewBoat:function(component, event, helper) {
        var boatTypeId = component.find("boatTypeSelect").get("v.value");
        //console.log('boat type: '+boatType);
       // var params = {"entityApiName": "Boat__c"};
       // if(boatTypeId){
        //    params.defaultFieldValues = {"BoatType__c" : boatTypeId};
        //}
        var createBoatRecordEvent = $A.get("e.force:createRecord");
        createBoatRecordEvent.setParams({
            "entityApiName": "Boat__c",
            'defaultFieldValues':{
                "BoatType__c" : boatTypeId
            }
        })
       // createBoatRecordEvent.setParams(params);  
        console.log('event: '+createBoatRecordEvent);
        createBoatRecordEvent.fire();
    },
    onFormSubmit: function(component, event, helper) {
        var boatTypeId = component.find("boatTypeSelect").get("v.value");
        var data = {
            "boatTypeId" : boatTypeId
        };

        var formsubmit = component.getEvent("formsubmit");
        formsubmit.setParams({
            "formData": data
        })
        formsubmit.fire();
    },
    // optionChange: function(component, event, helper) {
    //     var boatTypeId = component.find("boatTypeSelect").get("v.value");
    //     console.log('boat type Id: '+boatTypeId);

    // }
})
        