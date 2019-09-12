global class CustomerProcessingBatch implements Database.Batchable<sobject>
{
    global string[] email = new string[] {'himabindu.vuk@gmail.com'};
        //start method
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator('select Id,Name,apex_customer_status__c, apex_customer_description__c from apex_customer__c where APEX_Active__c =true');       
    }
    //execute method
    global void execute(Database.BatchableContext BC,List<sobject> scope)
    {
        List<apex_customer__c> updatedCustomerList = new List<apex_customer__c>();
        for(sobject objscope: scope)
        {
            apex_customer__c newObjScope = (apex_customer__c)objscope;
            newObjScope.APEX_Customer_Description__c = 'Updated via the batch job';
            newObjScope.APEX_Customer_Status__c = 'Paid';
            updatedCustomerList.add(newObjScope);
            system.debug('Records updated '+updatedCustomerList);
        }
		if(updatedCustomerList!= null && updatedCustomerList.size()>0)
        {
            Database.update(updatedCustomerList);
            system.debug('Records are successfully updated'+updatedCustomerList);
        }
    }
    global void finish(Database.BatchableContext BC)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      AsyncApexJob a = [select a.TotalJobItems, a.Status,a.NumberOfErrors, a.JobType,a.JobItemsProcessed,a.ExtendedStatus,
        a.createdById,a.CompletedDate from AsyncApexJob a where id=:BC.getJobId()];
        system.debug('Job Id'+BC.getJobId());
        mail.setToAddresses(email);
        mail.setReplyTo('hima.vuk@gmail.com');
        mail.setSenderDisplayName('Apex Batch Processing Module');
        mail.setSubject('Batch Processing'+a.status);
        mail.setPlainTextBody('the batch apex job processed '+a.TotalJobItems+ 'batches with '+a.NumberOfErrors+ 'failures'+'Job items processed are '+a.JobItemsProcessed);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}