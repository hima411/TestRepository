public class AccountListController2 
{
    public ApexPages.StandardSetController acct
    {
        get
        {
            if(acct == null)
            {
                acct = new ApexPages.StandardSetController(Database.getQueryLocator([select Name,AccountNumber,Type from Account]));
            }
            return acct;
        }
        set;
    }
    
    public List<Account> getAccounts() {
        return (List<Account>)acct.getRecords();
    }

}