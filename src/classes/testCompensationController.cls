@isTest
private class testCompensationController {

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

	@isTest static void getCompensationsTest6() {
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
}