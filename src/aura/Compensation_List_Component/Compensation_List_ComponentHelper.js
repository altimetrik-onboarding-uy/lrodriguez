({
	convertToCSV : function(compList) {
		// convert array of compensations into csv data
		var csvData = 'EMPLOYEE NAME,EMPLOYEE BIRTHDATE,JOB CATEGORY,COMPENSATION TYPE,'+
					'AMOUNT,LOCATION,OFFICE,SUBMITTED,STATUS\r\n';
		var i;
		for(i = 0; i < compList.length; i++){
			csvData += compList[i].Employee__r.Name + ',';
			csvData += compList[i].Employee__r.Birthdate + ',';
			csvData += compList[i].Job_Category__c + ',';
			csvData += compList[i].RecordType.Name + ',';
			csvData += compList[i].Amount__c + ',';
			csvData += compList[i].Location__c + ',';
			csvData += compList[i].Office__c + ',';
			csvData += compList[i].Submitted__c + ',';
			csvData += compList[i].Status__c + '\r\n';
		}
		if (csvData == null){
			return;
		}
		var time = new Date();
		var newElement = document.createElement('a');
		newElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csvData);
		newElement.target = '_self';
		newElement.download = 'ExportedData_'+ time.getTime().toString() +'.csv';
		document.body.appendChild(newElement);
		newElement.click();
	},
	updateSelection : function(component, event){
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
	}
})
