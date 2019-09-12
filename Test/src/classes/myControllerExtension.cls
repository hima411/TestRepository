public class myControllerExtension {

    private final Account acct;
    public myControllerExtension(ApexPages.StandardController stdController) {
    
        this.acct = (Account)stdController.getRecord();

    }
    public string getGreeting()
    {
        return 'hello '+acct.name+'('+acct.id+ ')';
    }

}