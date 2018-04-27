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
		var action = component.get("c.submitCompId");
		action.setParams({
            "idToSubmit": new_change['id']
        });
		action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
				if(response.getReturnValue()){
					alert("Selection submitted successfully");
				} else {
					alert("Something went wrong in the server, please refresh and retry.");
				}
            } else {
				alert("Error: Contact your system administrator.");
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	},
	exportCSV : function(component, event, helper){
		var compList = component.get("v.compensations");
		// convert array of compensations into csv data
		var csv = helper.convertToCSV(compList);
		if (csv == null){
			return;
		}
		var time = new Date();
		var newElement = document.createElement('a');
		newElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
		newElement.target = '_self';
		newElement.download = 'ExportedData_'+ time.getTime().toString() +'.csv';
		document.body.appendChild(newElement);
		newElement.click();
	}
})