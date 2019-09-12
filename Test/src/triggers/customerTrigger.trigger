trigger customerTrigger on APEX_Customer__c (after update, after insert) 
{
    if(trigger.isAfter && trigger.isUpdate)
    {
        //CustomerTriggerHelper1.isAfterUpdatecall(Trigger.new,Trigger.oldMap,Trigger.newMap);
        CustomerTriggerHelper.createInvoiceRecord(Trigger.new,Trigger.oldMap);
    }

}