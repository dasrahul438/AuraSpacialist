@RestResource(urlMapping='/project/*')
global class ProjectRESTService {
    
    
    @HttpPost
    global static String postProjectData(
        String	ProjectRef,
        String	ProjectName,
        String	OpportunityId,
        Date	StartDate,
        Date	EndDate,
        Double	Amount,
        String	Status){
            
            Savepoint sPoint = Database.setSavepoint();
            try{
                Project__c project = new Project__c();
                project.Name=ProjectName;
                project.Billable_Amount__c=Amount;
                project.ProjectRef__c=ProjectRef;
                project.Start_Date__c=StartDate;
                project.End_Date__c=EndDate;
                project.Status__c=Status;
                project.Opportunity__c = opportunityId;
                upsert project;
                
                
                Opportunity opp = new Opportunity();
                opp.Id=opportunityId;
                opp.DeliveryInstallationStatus__c='In Progress';
                update opp;
                return 'OK';
                
            }
            catch(Exception ex){
                Database.rollback(sPoint);
                return ex.getMessage();
            }
            
        }
    
    
}