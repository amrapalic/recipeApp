public class AccountTriggerHandler {
    
    public static void preventAccDeletion(Map<Id,Account> accMap) {
        System.debug('In Account Delete Check..');
        Set<Id> accIds = new Set<Id>();
        List<Account> accDelete = new List<Account>();
        List<Account> accNoDelete = new List<Account>();
        for(Account acc : accMap.values()) {
            accIds.add(acc.Id);
        }
        
        for(Account acc : [SELECT Id, Name, (SELECT Id, LastName FROM Contacts) FROM Account
                           WHERE Id IN :accIds]) {
                               List<Contact> ctList = acc.contacts;
                               if(ctList.size() == 0) {
                                   accDelete.add(acc);
                               }
                               else {
                                   accNoDelete.add(acc);
                               }
                           }
        System.debug('accounts to be deleted..' + accDelete);
        System.debug('accounts not to be deleted..' + accNoDelete);
        for(Account acc : accNoDelete) {
            accMap.get(acc.Id).addError('account associated with contact cannot be deleted !');
        }
        delete accDelete;
    }
    
    public static void createContact(List<Account> accList) {
        System.debug('in create contact..');
        List<Contact> ctsInsert = new List<Contact>();
        for(Account acc : accList) {
            if(acc.Industry == 'Banking') {
                Contact c = new Contact(LastName = acc.Name, Phone = acc.Phone, AccountId = acc.Id);
                ctsInsert.add(c);
            }
        }
        System.debug('ctsInsert..' + ctsInsert);
        insert ctsInsert;
    }
}