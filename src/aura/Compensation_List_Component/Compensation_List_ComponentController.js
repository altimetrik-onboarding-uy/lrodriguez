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
	},
	applyFilterSubmitted : function(component, event, helper){
		var submittedField = event.getSource().get('v.name');
		var action = component.get("c.getCompensations");
		action.setParams({
            "filter": submittedField
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
	handleUpdateSelection : function(component, event, helper){
		var new_change = event.getParam("selectionChange");
		var selected_rows = component.get("v.selected_comp");
		var is_in = selected_rows.indexOf(new_change['id'], 0) != -1;
		if ( is_in && !new_change['state']){
			selected_rows.pop(new_change['id']);
			component.set("v.selected_comp", selected_rows);
		} else if (!is_in && new_change['state']) {
			selected_rows.push(new_change['id']);
			component.set("v.selected_comp", selected_rows);
		}
		console.log("Selected rows " + selected_rows);
	},
	submitSelected : function(component, event, helper){
		var action = component.get("c.submitSelectedIds");
		var ids = component.get("selected_comp");
		action.setParams({
            "idsToSubmit": ids
        });
		action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                alert("Selection submitted successfully")
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	}
})
