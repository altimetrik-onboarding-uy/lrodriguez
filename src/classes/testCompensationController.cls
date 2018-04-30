@isTest
private class testCompensationController {

	@testSetup static void testDataSetup() {
		Contact	c = new Contact(lastname='Diaz');
		insert c;

		Compensation__c[] comp_list = new List<Compensation__c>();
		for (Integer i = 0; i < 10; i++){
			comp_list.add(new Compensation__c(Employee__c=c.Id, Name='test'+i,
											Job_Category__c='Junior', Location__c='India',
											Submitted__c = (math.mod(i, 2) == 0)));
		}
		insert comp_list;

		// Agregar cosas para el ultimo test aca.

	}

	@isTest static void getCompensationsTest1() {
		// get all compensations using SOQL.
		Compensation__c[] all_comp = [SELECT Id, Name FROM Compensation__c];
		Integer soql_count = all_comp.size();

		// get all compensations using static class method with the filter=all
		Test.startTest();
		Compensation__c[] all_comp_using_ctrl = CompensationController.getCompensations('all');
		Test.stopTest();

		// assert equals with both quantities
		Integer ctrl_count = all_comp_using_ctrl.size();
		System.assertEquals(soql_count, ctrl_count);
	}

	@isTest static void getCompensationsTest2() {
		// get compensations of type study using SOQL.
		Compensation__c[] all_comp = [SELECT Id, Name, RecordType.Name
									FROM Compensation__c
									WHERE RecordType.Name = 'study'];
		Integer soql_count = all_comp.size();

		// get all compensations using static class method with the filter=study
		Test.startTest();
		Compensation__c[] all_comp_using_ctrl = CompensationController.getCompensations('study');
		Test.stopTest();

		// assert equals with both quantities
		Integer ctrl_count = all_comp_using_ctrl.size();
		System.assertEquals(soql_count, ctrl_count);
	}

	@isTest static void getCompensationsTest3() {
		// get compensations of type salary using SOQL.
		Compensation__c[] all_comp = [SELECT Id, Name, RecordType.Name
									FROM Compensation__c
									WHERE RecordType.Name = 'salary'];
		Integer soql_count = all_comp.size();

		// get all compensations using static class method with the filter=salary
		Test.startTest();
		Compensation__c[] all_comp_using_ctrl = CompensationController.getCompensations('salary');
		Test.stopTest();

		// assert equals with both quantities
		Integer ctrl_count = all_comp_using_ctrl.size();
		System.assertEquals(soql_count, ctrl_count);
	}

	@isTest static void getCompensationsTest4() {
		// get compensations of type research using SOQL.
		Compensation__c[] all_comp = [SELECT Id, Name, RecordType.Name
									FROM Compensation__c
									WHERE RecordType.Name = 'research'];
		Integer soql_count = all_comp.size();

		// get all compensations using static class method with the filter=research
		Test.startTest();
		Compensation__c[] all_comp_using_ctrl = CompensationController.getCompensations('research');
		Test.stopTest();

		// assert equals with both quantities
		Integer ctrl_count = all_comp_using_ctrl.size();
		System.assertEquals(soql_count, ctrl_count);
	}

	@isTest static void getCompensationsTest5() {
		// get submitted compensations using SOQL.
		Compensation__c[] all_comp_submitted = [SELECT Id, Name, RecordType.Name
									FROM Compensation__c
									WHERE Submitted__c = true];
		Integer all_comp_submitted_count = all_comp_submitted.size();

		// get all compensations using static class method with the filter=submitted
		Test.startTest();
		Compensation__c[] all_comp_sub_ctrl = CompensationController.getCompensations('submitted');
		Test.stopTest();

		// assert equals with both quantities
		Integer all_comp_sub_ctrl_count = all_comp_sub_ctrl.size();
		System.assertEquals(all_comp_submitted_count, all_comp_sub_ctrl_count);
	}

	@isTest static void getCompensationsTest6() {
		// get not submitted compensations using SOQL.
		Compensation__c[] all_comp_not_submitted = [SELECT Id, Name, RecordType.Name
									FROM Compensation__c
									WHERE Submitted__c = false];
		Integer all_comp_not_submitted_count = all_comp_not_submitted.size();

		// get all compensations using static class method with the filter=not_submitted
		Test.startTest();
		Compensation__c[] all_comp_not_sub_ctrl = CompensationController.getCompensations('not_submitted');
		Test.stopTest();

		// assert equals with both quantities
		Integer all_comp_not_sub_ctrl_count = all_comp_not_sub_ctrl.size();
		System.assertEquals(all_comp_not_submitted_count, all_comp_not_sub_ctrl_count);
	}

	@isTest static void getCompensationsTest7() {
		// get compensations passing a non existent filter
		Test.startTest();
		Compensation__c[] empty_collection = CompensationController.getCompensations('dummy');
		Test.stopTest();
		// verify that the operation returns an empty collection.
		System.assertEquals(0, empty_collection.size());
	}

	@isTest static void getCompensationsOfUserTest1() {
		// get a compensation in order to get a contact with a compensation
		Compensation__c[] comps = [SELECT Id, Name, Employee__r.Id
									FROM Compensation__c
							    	LIMIT 1];
		// get Contact Id and Compensation Id of the first compensation returned.
		String ctc = comps[0].Employee__r.Id;
		String compId = comps[0].Id;

		// get Compensations of Contact Id using Compensation Controller.
		Test.startTest();
		Compensation__c[] comp_ctc = CompensationController.getCompensationsOfUser(ctc);
		Test.stopTest();

		//get the set of Ids in comp_ctc (the compensation set of Contact Id.)
		Set<String> id_set = new Set<String>();
		for (Compensation__c c: comp_ctc){
			id_set.add(c.Id);
		}
		// assert if compensation Id saved before belongs to the compensation's id's set.
		System.assert(id_set.contains(compId));
	}

	@isTest static void getCompensationsOfUserTest2() {
		// Create a contact without compenstions.
		Contact con = new Contact(lastname='vatikutti');
		insert con;

		// call the method with that contact Id
		Test.startTest();
		Compensation__c[] comps = CompensationController.getCompensationsOfUser(con.Id);
		Test.stopTest();

		// verify that the returned set is empty.
		System.assertEquals(0, comps.size());
	}

	@isTest static void submitCompIdTest1() {
		// test case: There is no compensation with that Id.
		// Verify that no error ocurr and the method returns false
		// because no compensation was submitted.
		Test.startTest();
		Boolean result = CompensationController.submitCompId('fake_id');
		Test.stopTest();
		System.assert(!result);
	}

	@isTest static void submitCompIdTest2() {
		// test case: There is a not submitted compensation with that Id.
		Compensation__c[] comp_not_submitted = [SELECT Id, Name, Submitted__c
									FROM Compensation__c
									WHERE Submitted__c = false];
		String comp_id = comp_not_submitted[0].Id;
		Test.startTest();
		Boolean result = CompensationController.submitCompId(comp_id);
		Test.stopTest();
		// Verify that no error ocurr and the method returns true.
		System.assert(result);
		Compensation__c[] comp_submitted = [SELECT Id, Name, Submitted__c
									FROM Compensation__c
									WHERE Id = :comp_id];
		// Verify that the compensation was submitted successfully.
		System.assertEquals(true, comp_submitted[0].Submitted__c);
	}
}
