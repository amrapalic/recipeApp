public with sharing class ChangeLanguageComponentController {
    @AuraEnabled
    public static boolean changeUserLanguage(String language) {
        if(language == UserInfo.getLanguage()) {
            return false;
        }
        else {
            User currentUser = [SELECT Id, LanguageLocaleKey FROM User WHERE Id=:UserInfo.getUserId()];
            currentUser.LanguageLocaleKey = language;
            update currentUser;
            return true;
        }
    }
}