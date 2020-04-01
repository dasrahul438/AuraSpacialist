@isTest
private class ProjectCalloutServiceTest {
    @TestSetup
    public static void createData(){
        ServiceTokens__c serviceToken = new ServiceTokens__c();
        serviceToken.Name = 'ProjectServiceToken';
        serviceToken.Token__c = 'qwertyuiopnjhgft';
        insert serviceToken;
        
        Account acc=new Account();
        acc.Name='Test Account';
        insert acc;
        
        
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'Test Opp1';
        opp1.Type = 'New Project';
        opp1.Amount = 100;
        opp1.CloseDate = Date.today();
        opp1.StageName = 'Submitted Project';
        insert opp1;
        
        //create the opportunity record
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'Test Opp2';
        opp2.Type = 'New Project';
        opp2.Amount = 200;
        opp2.CloseDate = Date.today();
        opp2.StageName = 'Resubmit Project';
        insert opp2;
        
        //create the Custom Settings
        
    }
    @IsTest
    public static void testFailure(){
        Opportunity opp = [Select Id, Name
                           FROM Opportunity
                           WHERE Name = 'Test Opp2' Limit 1];
        List<Id> lstOfOppIds = new List<Id>();
        lstOfOppIds.add(opp.Id);
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure());
        Test.startTest();
        ProjectCalloutService.postOpportunityToPMS(lstOfOppIds);
        Test.stopTest();
        List<Opportunity> updatedOpportunities = [SELECT Id, Name, StageName
                                                  FROM Opportunity
                                                  WHERE Name = 'Test Opp2' LIMIT 1];
        System.assertEquals('Resubmit Project', updatedOpportunities[0].StageName);
    }
    @isTest
    public static void testSuccess(){
        Opportunity opp = [Select Id, Name
                           FROM Opportunity
                           WHERE Name = 'Test Opp1' Limit 1];
        List<Id> lstOfOppIds = new List<Id>();
        lstOfOppIds.add(opp.Id);
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock());
        Test.startTest();
        ProjectCalloutService.postOpportunityToPMS(lstOfOppIds);
        Test.stopTest();
        List<Opportunity> updatedOpportunities = [SELECT Id, Name, StageName
                                                  FROM Opportunity
                                                  WHERE Name = 'Test Opp1' LIMIT 1];
        System.assertEquals('Submitted Project', updatedOpportunities[0].StageName);
    }
    
    
}