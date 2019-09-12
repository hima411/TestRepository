@isTest
private class CustomertriggerTestClass
{
    static testMethod void muUnitTest()
    {
        //create the data
        apex_customer__c objCust = new apex_customer__c();
         objCust.Name = 'Test Customer';
         objCust.apex_customer_status__c = 'Inactive';
         insert objCust;
         
         //updating
         
         Test.startTest();
         objCust.apex_customer_status__c = 'Active';
         update objCust;//trigger will get fired
         Test.stopTest();
         
         //see if our expected result is eqaul to expected result assert()
         List<Apex_invoice__c> invList = [select Id,apex_customer__c from apex_invoice__c where apex_customer__c = :objCust.Id];
         system.assertEquals(1,invList.size());
    }
    static testMethod void muUnitTest2()
    {
        //create the data
        apex_customer__c objCust = new apex_customer__c();
         objCust.Name = 'Test Customer';
         objCust.apex_customer_status__c = 'Inactive';
         insert objCust;
         
         //updating
         
         Test.startTest();
         objCust.apex_customer_status__c = 'Pending';
         update objCust;//trigger will get fired
         Test.stopTest();
         
         //see if our expected result is eqaul to expected result assert()
         List<Apex_invoice__c> invList = [select Id,apex_customer__c from apex_invoice__c where apex_customer__c = :objCust.Id];
         system.assertEquals(0,invList.size());
    }
}