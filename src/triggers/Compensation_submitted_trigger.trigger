trigger Compensation_submitted_trigger on Compensation__c (before insert, before update) {
    // When a comppensation is submitted(while creating or updating) status is automatically
    // set as SUBMITTED.
    for (Compensation__c comp: Trigger.new){
        if(comp.submitted__c){
            comp.status__c = 'SUBMITTED';
        }
    }
}
