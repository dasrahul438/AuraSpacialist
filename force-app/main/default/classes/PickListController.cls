public with sharing class PickListController{
	public PickListController(){
	}

	@AuraEnabled
	public static List<String> getPickListValuesIntoList(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
        for (Schema.PicklistEntry a : Schema.getGlobalDescribe().get(objectType).getDescribe().fields.getMap().get(selectedField).getDescribe().getPickListValues()){
            pickListValuesList.add(a.getValue());
        }
        System.debug(pickListValuesList);
        return pickListValuesList;
	}
}