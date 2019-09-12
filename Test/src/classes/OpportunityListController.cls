public class OpportunityListController 
{
    public ApexPages.StandardSetController opps
    {
        get
        {
            if(opps==null)
            {
                opps = new ApexPages.StandardSetController(Database.getQueryLocator([select Name,CloseDate,Amount from Opportunity]));
            }
            return opps;
        }
        set;
    }
    public List<Opportunity> getOpportunities() {
        return (List<Opportunity>)opps.getRecords();
    }





}