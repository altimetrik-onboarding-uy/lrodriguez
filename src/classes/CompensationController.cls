public with sharing class CompensationController {
	@AuraEnabled
    public static List<Compensation__c> getCompensations(){
        return [SELECT Employee__r.Name, Employee__r.birthdate,
			job_category__c, RecordType.Name, amount__c,
			location__c, office__c, submitted__c, status__c FROM Compensation__c];
    }
}
