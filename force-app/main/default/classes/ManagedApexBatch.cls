public with sharing class ManagedApexBatch implements Database.Batchable<sObject>{
    public Set<ID> accountIds;

    public ManagedApexBatch(Set<Id> ids){
        accountIds=ids;
    }

    public ManagedApexBatch(){
        accountIds=null;
    }

    public Database.QueryLocator start(Database.BatchableContext bc){
        String queryString='SELECT ID,OwnerId,AccountId FROM CONTACT ';
        if(accountIds!=null){
            queryString+=' WHERE AccountId In:accountIds';
        }
      return Database.getQueryLocator(queryString);
    }
    public void execute(Database.BatchableContext bc,List<Contact> scope){
        List<Contact> contactsToUpdate=new List<Contact>();
        Set<Id> scopeAccountIds=new Set<Id>();

        for(Contact con:scope){
            if(con.AccountId!=null){
                scopeAccountIds.add(con.AccountId);
            }
        }

        Map<Id, Account> changedAccountsMap=new Map<Id,Account>([SELECT ID,OwnerId FROM ACCOUNT WHERE Id in:scopeAccountIds]);

        for(Contact con:scope){
            Id newOwnerId=changedAccountsMap.get(con.AccountId).OwnerId;
            if(con.OwnerId!=newOwnerId){
                con.OwnerId=newOwnerId;
                contactsToUpdate.add(con);
            }
        }
        update contactsToUpdate;
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Job has been finished');
    }
        
        
    
}
