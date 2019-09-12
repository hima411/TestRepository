public class CustomerTriggerHelper
{
    public static void createInvoiceRecord(List<Apex_Customer__c> customerList, Map<id, apex_customer__c> oldMapCustomer)
    {
        List<apex_Invoice__c> invoiceList = new List<apex_Invoice__c>();
        for(apex_customer__c customerObject:customerList)
        {
            if(customerObject.apex_customer_status__c == 'Active' && oldMapCustomer.get(customerObject.id).apex_customer_status__c == 'Inactive')
            {
                Apex_Invoice__c invoiceObject = new apex_Invoice__c ();
                invoiceObject.APEX_Status__c = 'Pending';
                invoiceObject.APEX_Customer__c = customerObject.Id;
                invoiceObject.APEX_Description__c = 'record created through Trigger';
                invoiceList.add(invoiceObject);
            }
        }
        insert invoiceList;
    }
}