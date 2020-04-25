public class UpdateDefaultAccount {
    public static void createContact(List<Account> accList) {
        List<Contact> contacts = new List<Contact>();
        for(Account acc : accList) {
            acc.Only_Default_Contact__c = True;
            Contact con = new Contact(Email='info@websitedomain.tld',LastName='Default',AccountId=acc.Id);
        }
        insert contacts;
    }
    
    public static void updateDefaultContact(List<Account> accList) {
        
    }
}