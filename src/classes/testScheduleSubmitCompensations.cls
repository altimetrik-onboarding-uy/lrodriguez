@isTest
private class testScheduleSubmitCompensations {

	// Dummy CRON expression: midnight on March 15.
	// Because this is a test, job executes
	// immediately after Test.stopTest().
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    static testmethod void testScheduledJob() {
		Contact contact = new Contact(lastname='arleccino');
		insert contact;
		Compensation__c[] comps = new List<Compensation__c>();
		// insert 200 compensations to arleccino
		Date created_date = Date.today().addDays(-10);
		for (Integer i = 0; i < 5; i++) {
			comps.add(new Compensation__c(name='Testing comp ' + i,
				Job_Category__c='Senior', Location__c = 'India',
				Submitted__c = false, Created_Date__c = created_date,
				Employee__c = contact.Id));
		}
		insert comps;

        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new ScheduleSubmitCompensations());
        // Verify the scheduled job has not run yet. All compensations are not submitted
        Integer lc = [SELECT COUNT()
		              FROM Compensation__c
					  WHERE Employee__r.Name = 'arleccino' AND
					        Submitted__c = false];
        System.assertEquals(5, lc);
        // Stopping the test will run the job synchronously
        Test.stopTest();

		CronTrigger job = [SELECT State FROM CronTrigger WHERE Id = :jobId];

        System.assert((job.State=='COMPLETED')||(job.State=='WAITING'));
    }
}
