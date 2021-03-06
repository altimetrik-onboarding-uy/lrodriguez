public with sharing class CompensationController {
	@AuraEnabled
    public static List<Compensation__c> getCompensations(String filter){
		List<Compensation__c> compensations = new List<Compensation__c>();
		String query = 'SELECT Employee__r.Id, Employee__r.Name, Employee__r.birthdate, ' +
								'job_category__c, RecordType.Name, amount__c, ' +
								'location__c, office__c, submitted__c, status__c ' +
						'FROM Compensation__c';
		if (filter == 'all'){
			compensations = Database.query(query);
		} else if (filter == 'study' || filter == 'salary' || filter == 'research'){
			compensations = Database.query(query + ' WHERE RecordType.Name = \'' + filter + '\'');
		}
		return compensations;
    }

	@AuraEnabled
	public static List<Compensation__c> getCompensationsOfUser(String recordId){
		List<Compensation__c> compensations = new List<Compensation__c>();
		String query1 = 'SELECT Id, Name FROM Contact';
		String query2 = 'SELECT Employee__r.Id, Employee__r.Name, Employee__r.birthdate, ' +
								'job_category__c, RecordType.Name, amount__c, ' +
								'location__c, office__c, submitted__c, status__c ' +
						'FROM Compensation__c';
		List<Contact> cts = Database.query(query1 + ' WHERE Id = \'' + recordId + '\'');
		if (cts.size() > 0){
			compensations = Database.query(query2 + ' WHERE Employee__r.Id = \'' + recordId + '\'');
		}
		return compensations;
	}
}
