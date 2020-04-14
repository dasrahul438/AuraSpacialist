trigger ManagingAccountDataTrigger on Account (after update) {
    ManagingApex1.handleBatchAccountData(Trigger.new,Trigger.oldMap);
}