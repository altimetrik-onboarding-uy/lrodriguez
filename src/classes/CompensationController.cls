public with sharing class CompensationController {
	@AuraEnabled
    public static List<Compensation__c> getCompensations(String filter){
		List<Compensation__c> compensations = new List<Compensation__c>();
		if (filter == 'all'){
			compensations = [SELECT Employee__r.Id, Employee__r.Name, Employee__r.birthdate,
									job_category__c, RecordType.Name, amount__c,
									location__c, office__c, submitted__c, status__c
							FROM Compensation__c];
		} else if (filter == 'study' || filter == 'salary' || filter == 'research'){
			compensations = [SELECT Employee__r.Id, Employee__r.Name, Employee__r.birthdate,
									job_category__c, RecordType.Name, amount__c,
									location__c, office__c, submitted__c, status__c
							FROM Compensation__c
							WHERE RecordType.Name = :filter];
		}
		return compensations;
    }

	@AuraEnabled
	public static List<Compensation__c> getCompensationsOfUser(String recordId){
		List<Compensation__c> compensations = new List<Compensation__c>();
		List<Contact> cts = [SELECT Id, Name
							FROM Contact
							WHERE Id = :recordId];
		if (cts.size() > 0){
			compensations = [SELECT Employee__r.Id, Employee__r.Name, Employee__r.birthdate,
									job_category__c, RecordType.Name, amount__c,
									location__c, office__c, submitted__c, status__c
							FROM Compensation__c
							WHERE Employee__r.Id = :recordId];
		}
		return compensations;
	}


}
