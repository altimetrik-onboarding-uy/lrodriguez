global class ScheduleSubmitCompensations implements Schedulable {
	global void execute(SchedulableContext sc) {
		SubmitOldCompensations b = new SubmitOldCompensations();
		database.executebatch(b);
	}
}
