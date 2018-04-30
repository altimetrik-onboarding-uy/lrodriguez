@isTest
private class testEmailManager {
	// the following verifications include manual testing
	// method one involves checking lrodriguez@altimetrik.com inbox.
	// the second method use a dummy email address so no email will be sent.
	@isTest static void test_method_one() {
		// Test case: send an email to lrodriguez@altimetrik.com
		// verify that no error occur and the email is received.
		String body = 'Testing sendMail method of EmailManager class';
		EmailManager.sendMail('lrodriguez@altimetrik.com', 'Test method 1', body);
	}

	@isTest static void test_method_two() {
		// Test case: send an email to alohawaiialohawaii.com
		// verify that no error occur and no email is sent.
		String body = 'This will never arrive anywhere!... :(';
		EmailManager.sendMail('alohawaiialohawaii.com', 'Test method 2', body);
	}
}
