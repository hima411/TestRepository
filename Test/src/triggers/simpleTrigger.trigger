trigger simpleTrigger on Account (after insert) {

List<Contact> contactList = new List<Contact>();

for(Account a: Trigger.new)
    {
        //to create a corresponding contact record for newyly added account
        
        Contact c = new Contact();
        c.lastName = a.Name;
        c.AccountId = a.Id;
        c.Description = 'Contact created through Trigger';
        contactList.add(c);    
    }
insert contactList;
}