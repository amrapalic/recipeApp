public class OpportunityTriggerHandler {
    public static void updatePhoneNumbers(List<Opportunity> oppList) {
        //Set<Id> AccountIds = new Set<Id>();
        Map<Id,Opportunity> accOppMap = new Map<Id,Opportunity>();
        Set<Id> accIds = new Set<Id>();
        List<Contact> ctsUpdate = new List<Contact>();
        for(Opportunity opp : oppList) {
            if(opp.StageName == 'Closed Won') {
                accOppMap.put(opp.AccountId,opp);
                accIds.add(opp.AccountId);
                
            }
            List<Contact> contacts = [SELECT Id, LastName, Phone, AccountId FROM Contact WHERE AccountId IN :accIds];
        	for(Contact con : contacts) {
                con.Phone = accOppMap.get(con.AccountId).Phone_Number__c;
                ctsUpdate.add(con);
            }
        }
        System.debug(ctsUpdate);
      update ctsUpdate;
    }
    
    public static void updateAccountRating(List<Opportunity> oppList) {
        System.debug('In Account Update..');
        Set<Id> accIds = new Set<Id>();
        List<Account> accUpdate = new List<Account>();
        for(Opportunity opp : oppList) {
            if(opp.StageName == 'Closed Won') {
                accIds.add(opp.AccountId);
            }
            
        }
        for(Account acc : [SELECT Id, Name, Rating FROM Account WHERE Id IN :accIds]){
            System.debug(acc);
            acc.Rating = 'Hot';
            accUpdate.add(acc);
        }
        update accUpdate;
    }
}