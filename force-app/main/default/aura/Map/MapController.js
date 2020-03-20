({
    jsLoaded: function(component) {
        component.set("v.jsLoaded", true);
    },

    onPlotMapMarker : function(component, event, helper) {
        var location = component.get("v.location");
        var locationData={
            sObjectId:event.getParam("sObjectId"),
            lat:event.getParam("lat"),
            long:event.getParam("long"),
            label: event.getParam("label")

        };
        component.set("v.location", locationData);
    }


    // onPlotMapMarker: function (component, event, helper) {
    //     var lat = event.getParam('lat');
    //     var long = event.getParam('long');
    //     component.set('v.location', {
    //         lat: lat,
    //         long: long
    //     });
    // },
})