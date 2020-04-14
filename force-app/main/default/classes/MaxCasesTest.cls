@IsTest
public with sharing class MaxCasesTest {
    @IsTest static void noCasesToday(){
        Contact con=new Contact();
        con.LastName='Snow';
        insert con;

        Case mycase=new Case();
        mycase.contactId=con.Id;
        mycase.Status='New';
        insert mycase;

        case updatedCase=[SELECT Status FROM case WHERE Id=:mycase.Id LIMIT 1];
        System.assertEquals('New', updatedCase.Status,'case status same as updated case status');

    }

    @IsTest static void multiCasesTodayContact(){

        Contact con=new Contact();
        con.LastName='Snow';
        insert con;

        List<Case> oldCases=new List<Case>();
        for(integer i=0;i<2;i++){
            Case oldCase=new Case();
            oldCase.contactId=con.Id;
            oldCases.add(oldCase);
        }
         insert oldCases;

         Case newCase=new Case();
         newCase.contactId=con.Id;
         insert newCase;

         //find cases more than 2 
         Case updatedCase=[SELECT Status FROM Case WHERE Id=:newCase.Id LIMIT 1];
         System.assertEquals('Closed', updatedCase.Status,'case status same as updated case status');

    }

    
    @IsTest static void fourCasesTodayAccount(){
        Account acc=new Account();
        acc.Name='Winterfall';
        insert acc;

        List<Case> oldCases=new List<Case>();
        for(integer i=0;i<3;i++){
            Case oldCase=new Case();
            oldCase.AccountId=acc.Id;
            oldCases.add(oldCase);
        }
         insert oldCases;

         Case newCase=new Case();
         newCase.AccountId=acc.Id;
         insert newCase;

         //find cases more than 3
         Case updatedCase=[SELECT Status FROM Case WHERE Id=:newCase.Id LIMIT 1];
         System.assertEquals('Closed', updatedCase.Status,'case status same as updated case status');

    }
   
}
