public class AccountCustomController1 {

    public PageReference saveTheRecord() {
        update account;
        return null;
    }


   private final Account account;
   public AccountCustomController1()
   {
       account = [select id,Name,Site from Account where Id =: ApexPages.currentPage().getParameters().get('id')];
   }
   public Account getAccount()
   {
       return account;
   }
}