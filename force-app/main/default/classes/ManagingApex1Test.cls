@isTest
public with sharing class ManagingApex1Test {
    public Static final Integer NO_OF_ACCOUNTS=4;
    public Static final Integer CONTACTS_PER_ACCOUNT=3;

    @TestSetup
    static void makeData(){
        createTestAccountsData(NO_OF_ACCOUNTS,CONTACTS_PER_ACCOUNT);
    }
    

    @istest
    public static void testBasicOperation()
    {
        List<Account> accounts=[SELECT ID,OwnerId FROM Account];
        User u=getTestuser();
        System.runAs(u){
            System.debug('User is: '+u.UserName);
            for(Account acc: accounts){
                acc.OwnerId=u.Id;
            }

            Test.startTest();
            update accounts;
            Test.stopTest();

            List<Contact> contacts=[SELECT ID,OwnerId from Contact];
            for(Contact con:contacts){
                System.assertEquals(u.Id, con.OwnerId,'Both are Equal');
            }

        }

    }
    public static void createTestAccountsData(Integer noOfAccounts,Integer contactsPerAccount){

        //save duplicate records by setting this property to true. 
        //Prevent duplicate records from being saved by setting this property to false
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.AllowSave=true;

        List<Account> accounts=new List<Account>();
        for(Integer i=0;i<noOfAccounts;i++){
            accounts.add(new Account(Name='ASUR Company' +String.valueOf(i)));
        }
        Database.insert(accounts,dml);

        List<Contact> contacts=new List<Contact>();
        for(Account act:accounts){
            for(Integer c=0;c<contactsPerAccount;c++){
                contacts.add(new Contact(FirstName='Rahul' +String.valueOf(c),LastName='Das'+String.valueOf(c),AccountId=act.Id));
            }
        }
        Database.insert(contacts,dml);
    }
    public static User getTestuser()
    {
        User u = new User(Alias = 'pbp1', 
                          Email = 'playbyplay1@pluralsight.com', 
                          FirstName='Joe', LastName= 'Smith', 
                          TimeZoneSidKey = 'America/Los_Angeles', 
                          UserName = 'playbyplay1@pluralsight.com',
                          ProfileID = UserInfo.getProfileId(),
                          LocaleSidKey='en_US', 
                          EmailEncodingKey='UTF-8', 
                          LanguageLocaleKey = 'en_US');
        return u;
    }
}
