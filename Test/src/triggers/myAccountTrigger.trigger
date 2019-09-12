trigger myAccountTrigger on Account (before Insert) {

    if(Trigger.isInsert)
    {
        for(Account a: Trigger.New)
        {
            system.assertEquals('MyTutorialRack',a.Name);
            system.assertEquals('12345678',a.AccountNumber);
            system.assertEquals(100,a.NumberOfEmployees);
            system.assertEquals(200,a.AnnualRevenue);
        }
    }
}