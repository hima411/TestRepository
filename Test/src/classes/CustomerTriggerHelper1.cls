public class CustomerTriggerHelper1
{
    public static void isAfterUpdatecall(List<apex_customer__c> customerList, 
    Map<id,apex_customer__c> oldMapCustomer, Map<id,apex_customer__c> newMapCustomer)
    {
        createInvoiceRecord(customerList,oldMapCustomer);
        updateInvoiceDescription(customerList,newMapCustomer);
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
    Public static void updateInvoiceDescription(List<apex_customer__c> customerList, Map<id,apex_customer__c> newMapCustomer)
    {
        /*for(apex_customer__c objCust: customerList)
        {
           list<apex_invoice__c> invList =  [select id, name, apex_description__c from apex_invoice__c where apex_customer__c =:objCust.id];// hit governer limit
           for(apex_invoice__c invRec:invList)
           {
               invRec.apex_description__c = 'Updated through the trigger';
               update invRec;// hit governer limit 
           }
        }*/
       List<apex_customer__c> customerListwithInvoice = [select id,name,(select id,name,apex_description__c 
       from invoices__r) from apex_customer__c where Id in: newMapCustomer.keySet()];
       
       List<apex_invoice__c> invList = customerListwithInvoice[0].Invoices__r;//list with the invoices to be updated
      
       List<apex_invoice__c> invoiceToUpdateList = new List<apex_invoice__c>();//empty list
        
       for(apex_invoice__c objInv:invList)
       {
           objInv.apex_description__c = 'Ok to Pay';
           invoiceToUpdateList.add(objInv);//adding to empty list
           
       }
       update invoiceToUpdateList;
        
    }
}