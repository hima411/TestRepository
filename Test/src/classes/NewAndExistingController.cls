public class NewAndExistingController 
{
    public Account account{get; private set;}
    
    public NewAndExistingController()
    {
        Id id = ApexPages.currentPage().getParameters().get('Id');
        
        account = (id==null)?new Account():[select name,phone,industry from Account where Id =: id];
    }
    
    public PageReference save()
    {
        try
        {
            upsert(account);
        }
        catch(system.DMLException e)
        {
            ApexPages.addMessages(e);
            return null;
        }
        PageReference redirectSuccess = new ApexPages.StandardController(Account).view();
        return redirectSuccess;
    }
}