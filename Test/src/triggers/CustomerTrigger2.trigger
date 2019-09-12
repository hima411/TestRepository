trigger CustomerTrigger2 on APEX_Customer__c (before update) 
{
    List<apex_customer__c> customerList = new List<apex_customer__c>();
    for(apex_customer__c objCust: trigger.new)
    {
        system.debug('objCust current value '+objCust);
        if(objCust.APEX_Active__c == true)
        {
            objCust.APEX_Customer_Description__c = 'Updated';
            system.debug('the record which has satisfied the if condition '+objCust );
            //customerList.add(objCust);            
        }
    }
    //update customerList;
    
}