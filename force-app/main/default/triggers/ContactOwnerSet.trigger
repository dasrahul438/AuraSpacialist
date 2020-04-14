trigger ContactOwnerSet on Case (after insert){
	for (Case myCase : Trigger.New){
		if (myCase.ContactId != null){
			Contact con = [SELECT 
			                    ID
			              FROM Contact
			              WHERE Id = :myCase.ContactId];
			con.OwnerId = myCase.CreatedById;
			update con;
		}
		if (myCase.AccountId != null){
			Account acc = [SELECT 
			                    ID
			              FROM Account
			              WHERE Id = :myCase.AccountId];
			acc.OwnerId = myCase.CreatedById;
			update acc;
		}
	}
}