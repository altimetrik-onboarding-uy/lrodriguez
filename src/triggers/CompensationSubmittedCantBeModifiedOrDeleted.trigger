trigger CompensationSubmittedCantBeModifiedOrDeleted on Compensation__c (before update, before delete) {
    for (Compensation__c c: Trigger.old){
        if (c.submitted__c && Trigger.isUpdate){
            Trigger.newMap.get(c.Id).addError('Submitted compensations cannot be modified nor deleted');
        }else if (c.submitted__c && Trigger.isDelete){
            Trigger.oldMap.get(c.Id).addError('Submitted compensations cannot be modified nor deleted');
        }
    }
}