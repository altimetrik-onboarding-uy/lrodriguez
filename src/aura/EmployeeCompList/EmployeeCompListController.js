({
	doInit : function(component, event, helper) {
		var action = component.get("c.getCompensationsOfUser");
		var recId = component.get("v.recordId");
		action.setParams({
            "recordId": recId
        });
		action.setCallback(this, function(response) {
            var state = response.getState();
			var returnedList = response.getReturnValue();
            if (state === "SUCCESS") {
                component.set("v.compensations", returnedList);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	},
})
