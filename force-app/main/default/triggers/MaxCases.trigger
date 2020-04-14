trigger MaxCases on Case (before insert){
	for (Case myCase : Trigger.new){
		if (myCase.ContactId != null){
			//find all case with this contact created today
			List<Case> casesTodayFromContact = [SELECT 
			                                          Id
			                                    FROM Case
                                                WHERE contactId = :myCase.ContactId AND CreatedDate = TODAY];
            //if two are found closed  the case
            if(casesTodayFromContact.size()>=2){
                myCase.status='Closed';
            }
        }
        
        if(myCase.AccountId!=null){
            List<Case> casesTodayFromAccount = [SELECT 
			                                          Id
			                                    FROM Case
                                                WHERE AccountId = :myCase.AccountId AND CreatedDate = TODAY];
            //if more than 3 are found closed  the case
            if(casesTodayFromAccount.size()>=3){
                myCase.status='Closed';
            }
        }
	}
}