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
		} else if (filter == 'submitted' || filter == 'not_submitted'){
			String condition = 'false';
			if (filter == 'submitted'){
				condition = 'true';
			}
			compensations = Database.query(query + ' WHERE Submitted__c = ' + condition);
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

	@AuraEnabled
	public static Boolean submitCompId(String idToSubmit){
		String query = 'SELECT Id, Name, submitted__c FROM Compensation__c';
		Compensation__c[] comps = Database.query(query + ' WHERE Id = \'' + idToSubmit + '\'');
		for(Compensation__c c: comps){
			c.submitted__c = true;
		}
		Database.SaveResult[] result = Database.update(comps, false);
		for(Database.SaveResult sr : result){
			if (!sr.isSuccess()){
				return false;
			}
		}
		return true;
	}
}
