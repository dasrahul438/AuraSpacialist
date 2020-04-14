public with sharing class ManagingApex1 {

    public static void handleBatchAccountData(List<Account> newAccounts,Map<Id,Account> oldAccounts){
        //List<Account> changedAccounts=new List<Account>();
        Map<Id,Account> changedAccountsMap=new Map<Id,Account>();
        for(Account act:newAccounts){
            if(act.OwnerId!=oldAccounts.get(act.Id).OwnerId){
                //changedAccounts.add(act.OwnerId);
                changedAccountsMap.put(act.Id, act);
            }
        }

        if(changedAccountsMap.size()==0) return;

        ManagedApexBatch batchClass=new ManagedApexBatch(changedAccountsMap.keySet());
        Database.executeBatch(batchClass, (Test.isRunningTest())?2000: 200);
        
        // List<Contact> newContacts=[SELECT Id,OwnerId,AccountId FROM Contact WHERE AccountId In :changedAccountsMap.keySet()];
        // List<Contact> contactsToUpdate=new List<Contact>();

        // for(Contact con: newContacts){
        //     Id newOwnerId=changedAccountsMap.get(con.AccountId).OwnerId;
        //     if(con.OwnerId!=newOwnerId){
        //         con.OwnerId=newOwnerId;
        //         contactsToUpdate.add(con);
        //     }
        // }
        // update contactsToUpdate;
        

    }
}
