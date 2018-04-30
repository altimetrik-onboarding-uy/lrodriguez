global class SubmitOldCompensations implements
	Database.Batchable<sObject>, Database.Stateful {

	String query = 'SELECT Id, Submitted__c, Created_Date__c ' +
					'FROM Compensation__c ' +
					'WHERE (Submitted__c = false) AND Created_Date__c < ';

	global Database.QueryLocator start(Database.BatchableContext BC) {
		Date twoDaysBefore = Date.today().addDays(-2);
		return Database.getQueryLocator(query + ':twoDaysBefore');
	}

   	global void execute(Database.BatchableContext BC, List<Compensation__c> scope) {
		for(Compensation__c c: scope){
			c.submitted__c = true;
		}
		Database.SaveResult[] result = Database.update(scope, false);
	}

	global void finish(Database.BatchableContext BC) {
		String body = 'Job completed successfully on ' + DateTime.now();
		EmailManager.sendMail('lrodriguez@altimetrik.com', 'Schedule job done', body);
	}
}
