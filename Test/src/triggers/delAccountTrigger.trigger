trigger delAccountTrigger on Account (before delete) {

    if(Trigger.isBefore)
    {
        if(Trigger.isDelete)
        {
            //in a before delete trigger, the trigger access with Trigger.old list
            
            for(account a: Trigger.old)
            {
                if(a.Name!='okToDelete')
                {
                    a.addError('You cannot delete this account record');
                }
            
            }              
            
        }
    }
    
}