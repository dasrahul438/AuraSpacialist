public class BillingCalloutService {
    
    public static final String BILLING_SERVICE_CREDENTIAL_NAME = 'BillingServiceCredential';
    static final ServiceCredentials__c credential = ServiceCredentials__c.getInstance(BILLING_SERVICE_CREDENTIAL_NAME);
    
    public static void callBillingService ( List<Project__c> newProjects, Map<Id, Project__c> oldProjects ) {
        List<Project__c> projectsToSync = new List<Project__c>();
        
        for(Project__c newProj:newProjects){
            Project__c oldProj=oldProjects.get(newProj.Id);
            if(meetCriteria(newProj,oldProj)){
                projectsToSync.add(newProj);
            }
            
            if(projectsToSync.size()>0){
                makeCallOut(JSON.serialize(projectsToSync));
            }        
        }
    }
    
    @future(callout=true)
    public static void makeCallOut(String projectsToSync){
        List<Project__c> recordsToBeProcessed = (List<Project__c>)JSON.deserialize(projectsToSync, List<Project__c>.class);
        List<Project__c> projectsToUpdate = new List<Project__c>();
        for(Project__c proj:recordsToBeProcessed){
            BillingServiceProxy.InvoicesPortSoap11 invoicePort =new BillingServiceProxy.InvoicesPortSoap11();
            BillingServiceProxy.project extProject = setAndGetExternalProject(proj);
            String response=invoicePort.billProject(extproject);
            
            if(response=='OK'){
                proj.Status__c='Billed';
                projectsToUpdate.add(proj);
            }
            if(projectsToUpdate.size()>0){
                update projectsToUpdate;
            }
  
        }
   
    }
    
    public static  BillingServiceProxy.project setAndGetExternalProject( Project__c proj){
        BillingServiceProxy.project extproject=new BillingServiceProxy.project();
        extproject.projectid=proj.ProjectRef__c;
        extproject.billAmount=proj.Billable_Amount__c;
        extproject.username=credential.Username__c;
        extproject.password=credential.Password__c;
        return extproject;
        
    }
    public static Boolean meetCriteria(Project__c newProj,Project__c oldProj){
        Boolean flag=false;
        if(newProj.Status__c=='Billable' &&  newProj.Status__c!=oldProj.Status__c){
            flag=true;
        }
        return flag;
    }
    
}