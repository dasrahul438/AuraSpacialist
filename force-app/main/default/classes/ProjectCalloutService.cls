public class ProjectCalloutService {
    //Complete the implementation for business and callout logic
    public static final String PROJECT_SERVICE_TOKEN_NAME = 'ProjectServiceToken';
    
    @invocableMethod
    public static void postOpportunityToPMS(List<Id> opportunityIds){
        if(opportunityIds.size()>0){
            System.enqueueJob(new QueueablePMSCall(opportunityIds));
        }
        
    }
    
    static void makeCallOut(Opportunity opp, String projectServiceToken){
        HttpResponse response=getHttpRequest(opp,projectServiceToken);
        if(response.getStatusCode() == 201 && response.getStatus() == 'OK'){
            opp.StageName = 'Submitted Project';
        }
        if(response.getStatusCode() == 500){
            opp.StageName = 'Resubmit Project';
        }
        update opp;    
    }
    
    static HttpResponse getHttpRequest(Opportunity opp, String projectServiceToken){
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('token', projectServiceToken);
        request.setEndpoint('callout:ProjectService');
        request.setBody(JSON.serialize(new CalloutInformationWrapper(opp)));
        HttpResponse response = new Http().send(request);
        return response;
    }
    
    
    static void collectDataAndCallOut(List<Id> opportunitiyIds){
        Opportunity opportunitiesToProcess=[select Id,Name,Account.Name,CloseDate, Amount from Opportunity where Id=:opportunitiyIds[0]];
        if(opportunitiesToProcess!=null){
            makeCallout(opportunitiesToProcess,ServiceTokens__c.getInstance(PROJECT_SERVICE_TOKEN_NAME).Token__c);
        }   
    }    
    
    public class QueueablePMSCall implements System.Queueable, Database.AllowsCallouts{
        List<Id> opportunitiyIdsToProcess;
        
        public QueueablePMSCall(List<Id> opportunitiyIds){
            opportunitiyIdsToProcess = opportunitiyIds;
        }
        
        public void execute(System.QueueableContext context){
            collectDataAndCallOut(opportunitiyIdsToProcess);  
        }
        
    }
    
    public class CalloutInformationWrapper{
        string opportunityId;
        string opportunityName;
        string accountName;
        string closeDate;
        Decimal amount;
        
        public CalloutInformationWrapper(Opportunity opp){
            this.opportunityId = opp.Id;
            this.opportunityName = opp.Name;
            this.accountName = opp.Account.Name;
            this.closeDate = String.valueOf(opp.CloseDate);
            this.amount = opp.Amount;
        }
    }
}