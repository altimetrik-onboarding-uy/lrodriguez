@isTest
private class testSubmitOldCompensations {

	@testSetup
    static void setup() {
		Contact contact = new Contact(lastname='rudolf');
		insert contact;
		Compensation__c[] comps = new List<Compensation__c>();
        // insert 200 compensations to rudolf
		Date created_date = Date.today().addDays(-10);
        for (Integer i = 0; i < 200; i++) {
            comps.add(new Compensation__c(name='Testing comp ' + i,
                Job_Category__c='Senior', Location__c = 'India',
				Submitted__c = false, Created_Date__c = created_date,
				Employee__c = contact.Id));
        }
        insert comps;
    }

	@isTest static void test_method_one() {
		Test.startTest();
        SubmitOldCompensations soc = new SubmitOldCompensations();
        Id batchId = Database.executeBatch(soc);
        Test.stopTest();

        System.assertEquals(200, [SELECT COUNT() FROM Compensation__c
								  WHERE Employee__r.Name = 'rudolf' AND Submitted__c = true]);
	}
}
