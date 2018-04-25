({
	doInit : function(component, event, helper) {
		var comp = component.get("v.compensation");
		var date_of_birth = comp.Employee__r.Birthdate;
		if (date_of_birth != undefined){
			component.set("v.birthdate", date_of_birth);
		}
	},
	editRecord : function(component, event, helper) {
		var comp = component.get("v.compensation");
	    var editRecordEvent = $A.get("e.force:editRecord");
	    editRecordEvent.setParams({
	         "recordId": comp.Employee__r.Id
	    });
	    editRecordEvent.fire();
	}
})
