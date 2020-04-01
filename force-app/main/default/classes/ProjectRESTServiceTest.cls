@isTest
private class ProjectRESTServiceTest {
    
    @testSetup
    static void setup(){       
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test Opp';
        opp.Type = 'New Project';
        opp.CloseDate = Date.today();
        opp.StageName = 'Prospecting';
        opp.Amount = 100000;
        insert opp;
    }
    
    @isTest
    static void testProjectRestServiceFailure(){
        RestRequest rs=new RestRequest();
        rs.httpMethod='POST';
        rs.requestURI='/services/apexrest/project/';
        RestContext.request=rs;
        
        Test.startTest();
        String response=ProjectRESTService.postProjectData(
            'Test Ref 123', 
            'Test Project', 
            'test opp id', 
            Date.today(), 
            Date.today().addDays(1), 
            110000, 
            'Running');
        Test.stopTest();
        System.assertEquals('Invalid id: test opp id', response);
    }
    
    @isTest
    static void testProjectRestServiceSuccess(){
        Opportunity opp=[select Id from Opportunity where Name='Test Opp'];
        
        RestRequest rs=new RestRequest();
        rs.httpMethod='POST';
        rs.requestURI='/services/apexrest/project/';
        RestContext.request=rs;
        
        Test.startTest();
        String response=ProjectRESTService.postProjectData(
            'Test Ref 123', 
            'Test Project', 
            opp.Id, 
            Date.today(), 
            Date.today().addDays(1), 
            110000, 
            'Running');
        Test.stopTest();
        
        opp = [SELECT Id,DeliveryInstallationStatus__c FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals('In Progress', opp.DeliveryInstallationStatus__c);
        System.assertEquals('OK', response);     
    }
    
}