({
  loadMap: function(component, event, helper, account) {
    var mapMarkers = [];
  //  if (account.size() > 0) {
      for (var i = 0; i < account.length; i++) {
        var Mobj = {
          location: {
            Street: account[i].BillingStreet,
            City: account[i].BillingCity,
            PostalCode: account[i].BillingPostalCode,
            State: account[i].BillingState,
            Country: account[i].BillingCountry
          },
          icon: "standard:account",
          title: account[i].Name,
          description: account[i].Website
        };
        mapMarkers.push(Mobj);
      }
      component.set('v.mapMarkers',mapMarkers);
      component.set('v.zoomLevel', 12);
      component.set('v.showFooter', true);
  //  }
  }
});
