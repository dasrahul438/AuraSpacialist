({
    doInit : function(component, event, helper) {

        let action = component.get("c.fetchAllAccounts");	
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state =='SUCCESS'){
                let result = response.getReturnValue();	
                console.log('Result returned: ' +JSON.stringify(result));	  
                component.set("v.accObj",result);	
                var accounts=component.get('v.accObj');
                helper.loadMap(component, event, helper,accounts);
            }
            else{
                console.log('something went wrong...');
            }
        });
        $A.enqueueAction(action);
    }
})
