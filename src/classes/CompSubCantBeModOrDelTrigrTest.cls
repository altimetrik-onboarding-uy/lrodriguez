@isTest
private class CompSubCantBeModOrDelTrigrTest {

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

	@isTest static void test_method_beforeUpdate1() {
		// Create a new compensation and insert it (submitted__c=false).
		Contact[] contacts = [SELECT Id, Name
							FROM Contact
							LIMIT 2];
		Compensation__c comp = new Compensation__c(Name='testingComp11',
												Employee__c=contacts[0].Id,
												Location__c='India',
												Job_Category__c='Junior',
												Submitted__c=false);
		insert comp;

		// get the new compensation from the database, modify the Amount__c
		Compensation__c[] fresh_comp = [SELECT Id, Name, Status__c, Amount__c
										FROM Compensation__c
										WHERE Id = :comp.Id];

		// update amount field (do not modify submitted checkbox)
		fresh_comp[0].amount__c = 12345;
		Test.startTest();
		Database.SaveResult res = Database.update(fresh_comp[0], false);
		Test.stopTest();

		// Verify that was possible to update the compensation.
		System.assert(res.isSuccess());
	}

	@isTest static void test_method_beforeUpdate2() {
		// Create a new compensation and insert it (submitted__c=true).
		Contact[] contacts = [SELECT Id, Name
							FROM Contact
							LIMIT 2];
		Compensation__c comp = new Compensation__c(Name='testingComp22',
												Employee__c=contacts[0].Id,
												Location__c='India',
												Job_Category__c='Junior',
												Submitted__c=true);
		insert comp;

		// get the new compensation from the database, modify the Job_Category__c
		Compensation__c[] fresh_comp = [SELECT Id, Name, Status__c, Job_Category__c
										FROM Compensation__c
										WHERE Id = :comp.Id];

		// update the compensation back to the Database
		fresh_comp[0].Job_Category__c = 'Senior';
		Test.startTest();
		Database.SaveResult res = Database.update(fresh_comp[0], false);
		Test.stopTest();

		// Verify that it was not possible to update the compensation.
		System.assert(!res.isSuccess());
	}

	@isTest static void test_method_beforeDelete1() {
		// Create a new compensation and insert it (submitted__c=false).
		Contact[] contacts = [SELECT Id, Name
							FROM Contact
							LIMIT 2];
		Compensation__c comp = new Compensation__c(Name='testingComp11',
												Employee__c=contacts[0].Id,
												Location__c='India',
												Job_Category__c='Junior',
												Submitted__c=false);
		insert comp;

		// get the new compensation from the database
		Compensation__c[] fresh_comp = [SELECT Id, Name, Status__c, Amount__c
										FROM Compensation__c
										WHERE Id = :comp.Id];

		// delete the compensation from to the Database
		Test.startTest();
		Database.DeleteResult res = Database.delete(fresh_comp[0], false);
		Test.stopTest();

		// Verify that was possible to delete the compensation.
		System.assert(res.isSuccess());
	}

	@isTest static void test_method_beforeDelete2() {
		// Create a new compensation and insert it (submitted__c=true).
		Contact[] contacts = [SELECT Id, Name
							FROM Contact
							LIMIT 2];
		Compensation__c comp = new Compensation__c(Name='testingComp11',
												Employee__c=contacts[0].Id,
												Location__c='India',
												Job_Category__c='Junior',
												Submitted__c=true);
		insert comp;

		// get the new compensation from the database
		Compensation__c[] fresh_comp = [SELECT Id, Name, Status__c, Amount__c
										FROM Compensation__c
										WHERE Id = :comp.Id];

		// delete the compensation from to the Database
		Test.startTest();
		Database.DeleteResult res = Database.delete(fresh_comp[0], false);
		Test.stopTest();
		// Verify that it was not possible to delete the compensation.
		System.assert(!res.isSuccess());
	}
}