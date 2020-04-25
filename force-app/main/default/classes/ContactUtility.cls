public with sharing class ContactUtility {
    
    @Auraenabled(cacheable=true)
    public static List<Contact> getContacts(String accountId) {
        List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE Id=:accountId];
        return contacts;
    }

}