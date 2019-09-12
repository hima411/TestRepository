public class BadCustomerTriggerHelper1
{
    public static void isAfterUpdatecall(List<apex_customer__c> customerList, Map<id,apex_customer__c> oldMapCustomer)
    {
        createInvoiceRecord(customerList,oldMapCustomer);
        updateInvoiceDescription(customerList);
    }
    public static void createInvoiceRecord(List<apex_customer__c> customerList, Map<id,apex_customer__c> oldMapCustomer)
    {
        
        list<apex_invoice__c> invoiceList = new list<apex_invoice__c>();
        
        for(apex_customer__c customerObject:customerList)
        {
            if(customerObject.apex_customer_status__c == 'Active' && oldMapCustomer.get(customerObject.id).apex_customer_status__c != 'Active')
            {  
                apex_invoice__c invoiceRecord = new apex_invoice__c();
                invoiceRecord.apex_status__c = 'Pending';
                invoiceRecord.apex_customer__c = customerObject.id;
                invoiceList.add( invoiceRecord);               
            }
        }
        insert invoiceList;
    }
    Public static void updateInvoiceDescription(List<apex_customer__c> customerList)
    {
        for(apex_customer__c objCust: customerList)
        {
           list<apex_invoice__c> invList =  [select id, name, apex_description__c from apex_invoice__c where apex_customer__c =:objCust.id];// hit governer limit
           for(apex_invoice__c invRec:invList)
           {
               invRec.apex_description__c = 'Updated through the trigger';
               update invRec;// hit governer limit 
           }
        }
    }
}