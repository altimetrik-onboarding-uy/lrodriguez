@isTest
private class CompensationSubmittedTriggerTest {

	@testSetup static void testDataSetup() {
		Contact	c = new Contact(lastname='Diaz');
		insert c;

		Compensation__c[] comp_list = new List<Compensation__c>();
		for (Integer i = 0; i < 10; i++){
			comp_list.add(new Compensation__c(Employee__c=c.Id, Name='test'+i,
											Job_Category__c='Junior', Location__c='India'));
		}
		insert comp_list;
	}


	@isTest static void test_method_before_insert1() {
		// Create a new compensation with submitted field unchecked.
		Contact[] contacts = [SELECT Id, Name
							FROM Contact
							LIMIT 2];
		Compensation__c comp = new Compensation__c(Name='testingComp1',
												Employee__c=contacts[0].Id,
												Location__c='India',
												Job_Category__c='Junior');
		insert comp;

		// get the new compensation from the database
		Compensation__c[] fresh_comp = [SELECT Id, Name, Status__c
										FROM Compensation__c
										WHERE Id = :comp.Id];

		// verify that status is 'not submitted'.
		System.assertEquals('NOT SUBMITTED', fresh_comp[0].Status__c);
	}

	@isTest static void test_method_before_insert2() {
		// Create a new compensation with submitted field checked.
		Contact[] contacts = [SELECT Id, Name
							FROM Contact
							LIMIT 2];
		Compensation__c comp = new Compensation__c(Name='testingComp2',
												Employee__c=contacts[0].Id,
												Location__c='India',
												Job_Category__c='Senior',
												Submitted__c=true,
												Status__c='NOT SUBMITTED');
		insert comp;

		// get the new compensation from the database
		Compensation__c[] fresh_comp = [SELECT Id, Name, Status__c
										FROM Compensation__c
										WHERE Id = :comp.Id];

		// verify that status is 'submitted'.
		System.assertEquals('SUBMITTED', fresh_comp[0].Status__c);
	}

	@isTest static void test_method_before_update1() {
		// Create a new compensation with submitted field unchecked.
		Contact[] contacts = [SELECT Id, Name
							FROM Contact
							LIMIT 2];
		Compensation__c comp = new Compensation__c(Name='testingComp1',
												Employee__c=contacts[0].Id,
												Location__c='India',
												Job_Category__c='Junior');
		insert comp;

		// get the new compensation from the database
		Compensation__c[] fresh_comp = [SELECT Id, Name, Status__c, Amount__c
										FROM Compensation__c
										WHERE Id = :comp.Id];

		// verify that status is 'not submitted'.
		System.assertEquals('NOT SUBMITTED', fresh_comp[0].Status__c);

		// update amount field (do not modify submitted checkbox)
		fresh_comp[0].amount__c = 12345;
		update fresh_comp;

		// get again the new compensation from the database
		Compensation__c[] fresh_comp1 = [SELECT Id, Name, Status__c, Amount__c
										FROM Compensation__c
										WHERE Id = :comp.Id];

		// verify that status is 'not submitted'.
		System.assertEquals('NOT SUBMITTED', fresh_comp1[0].Status__c);
	}

	@isTest static void test_method_before_update2() {
		// Create a new compensation with submitted field unchecked.
		Contact[] contacts = [SELECT Id, Name
							FROM Contact
							LIMIT 2];
		Compensation__c comp = new Compensation__c(Name='testingComp1',
												Employee__c=contacts[0].Id,
												Location__c='India',
												Job_Category__c='Junior');
		insert comp;

		// get the new compensation from the database
		Compensation__c[] fresh_comp = [SELECT Id, Name, Status__c, Amount__c
										FROM Compensation__c
										WHERE Id = :comp.Id];

		// verify that status is 'not submitted'.
		System.assertEquals('NOT SUBMITTED', fresh_comp[0].Status__c);

		// update submitted field to 'checked'
		fresh_comp[0].submitted__c = true;
		update fresh_comp;

		// get again the new compensation from the database
		Compensation__c[] fresh_comp1 = [SELECT Id, Name, Status__c, Amount__c
										FROM Compensation__c
										WHERE Id = :comp.Id];

		// verify that status is 'submitted'.
		System.assertEquals('SUBMITTED', fresh_comp1[0].Status__c);
	}
}