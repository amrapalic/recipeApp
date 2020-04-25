public class UpdateAccountNumberUtility {
    
    //public enum accountRT {CLI, OPE, DIST}
    Static Map<String,Integer> recordTypeCountMap = getLastCount();
    Static Integer cliCount = recordTypeCountMap.get('Client');
    Static Integer distCount = recordTypeCountMap.get('Distributor');
    Static Integer opeCount = recordTypeCountMap.get('Operator');
    
    
    public static List<Account> getAccounts(String recordTypeName) {
        List<Account> accounts = [SELECT Id, RecordTypeId, AccountNumber, RecordType.Name FROM Account WHERE RecordType.Name = :recordTypeName
                                  ORDER BY CreatedDate DESC LIMIT 1];
        return accounts;
    }
    
    
    public static Map<Id,String> getAccountRT() {
        Map<Id,String> accRecordTypes = New Map<Id,String>();
        for(RecordType rt : [SELECT Id,Name FROM RecordType WHERE SobjectType='Account']) {
            accRecordTypes.put(rt.Id,rt.Name);
        } 
        return accRecordTypes;
    } 
    
    public static Map<String,Integer> getLastCount() {
        Map<Id,String> accRTs =  getAccountRT();
        Map<String,Integer> lastCountMap = new Map<String,Integer>();
        Integer lastCount;
        for(String rt : accRTs.values()) {
            List<Account> accounts = UpdateAccountNumberUtility.getAccounts(rt);
            System.debug(accounts);
            if(accounts.size() != 0) {
                lastCount = Integer.valueOf(accounts[0].AccountNumber.substring(2));
            }
            else {
                lastCount = 0;
            }
                
   lastCountMap.put(rt,lastCount);
        }
        return lastCountMap;
    }
    
    public static void updateAccounts(List<Account> accList) {
        
        System.debug('Update Accounts Called---');
        Map<Id,String> accRecordTypes = getAccountRT();
        
        System.debug('---recordTypeCountMap---' + recordTypeCountMap);
        System.debug(accRecordTypes);
        
        for(Account acc : accList) {
            
           String rtName = accRecordTypes.get(acc.RecordTypeId);
            System.debug('Record Type Name --' + rtName);
            switch on rtName {
                when 'Client' {
                    System.debug('In Client Update--');
                    Integer latestCount = cliCount+1;
                    acc.AccountNumber = 'CL'+latestCount;
                    cliCount++;
                }
                when 'Distributor' {
                    System.debug('In Distributor Update--');
                    Integer latestCount = distCount+1;
                    acc.AccountNumber = 'DI'+latestCount;
                    distCount++;
                }
                when 'Operator' {
                    System.debug('In Operator Update--');
                    Integer latestCount = opeCount+1;
                    acc.AccountNumber = 'OP'+latestCount;
                    opeCount++;
                }
            }
           
        }
        
        
}
}