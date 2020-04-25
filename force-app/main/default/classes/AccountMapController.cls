public with sharing class AccountMapController {
    
    @AuraEnabled
    public static List<AccountLocationWrapper> getLocations() {
        List<AccountLocationWrapper> returnList = new List<AccountLocationWrapper>();
        List<Account> accList = [Select Name,description, BillingCountry, BillingCity, BillingPostalCode, BillingStreet, 
                                 BillingState FROM Account WHERE BillingCountry != null AND BillingCity != null
                                 limit 10];
            for(Account acc : accList) {
                LocationWrapper loc = new LocationWrapper();
                loc.Street = acc.BillingStreet;
                loc.PostalCode = acc.BillingPostalCode;
                loc.City = acc.BillingCity;
                loc.State = acc.BillingState;
                loc.Country = acc.BillingCountry;
                
                AccountLocationWrapper accLoc = new AccountLocationWrapper();
                accLoc.title = acc.Name;
                accLoc.description = acc.Description;
                accLoc.location = loc;
                
                returnList.add(accLoc);
            }
        return returnList;
                           
    }
    
	
    public class AccountLocationWrapper {
        //@AuraEnabled public String Icon {get;set;}
        @AuraEnabled public String title {get;set;}
		@AuraEnabled public String description {get;set;} 
        @AuraEnabled public LocationWrapper location{get;set;}
    }
    
    public class LocationWrapper {
        @AuraEnabled public String Street {get;set;}
        @AuraEnabled public String PostalCode {get;set;}
        @AuraEnabled public String City {get;set;}
        @AuraEnabled public String State {get;set;}
        @AuraEnabled public String Country {get;set;}
    }
   	
}