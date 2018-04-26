({
	convertToCSV : function(compList) {
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
		return csvData;
	}
})
