({
    initSearch:function(component,event,helper){
       // console.log('inside Boat search class');
        helper.onSearch(component);
    },
    doSearch : function(component, event, helper) {
        var params=event.getParam('arguments');
        component.set('v.boatTypeId',params.boatTypeId);
        helper.onSearch(component);

    },
    onBoatSelect:function(component, event, helper) {
        var boatId=event.getParam('boatId');
        component.set('v.selectedBoatId',boatId);
    }
    })