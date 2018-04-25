({
	doInit : function(component, event, helper) {
		var action = component.get("c.getCompensations");
		var comp_type = 'all';
		action.setParams({
            "filter": comp_type
        });
		action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.compensations", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	},
	applyFilter : function(component, event, helper) {
		var filterOption = event.getSource().get('v.name');
		var action = component.get("c.getCompensations");
		action.setParams({
            "filter": filterOption
        });
		action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.compensations", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	}
})
