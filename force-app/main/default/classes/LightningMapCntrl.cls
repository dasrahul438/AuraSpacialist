public with sharing class LightningMapCntrl{
	@AuraEnabled
	public static List<Account> fetchAllAccounts(){
		List<Account> accList = [Select 
		                               Id, 
		                               Name, 
		                               Website, 
		                               BillingCity, 
		                               BillingStreet, 
		                               BillingPostalCode, 
		                               BillingState, 
		                               BillingCountry
		                         from Account LIMIT 10];
		return accList;
	}
}