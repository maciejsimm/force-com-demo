public class PatientRegisterVisitCtrl {

    public Contact patient {get;set;}
    public List<Appointment_Slot__c> slots {get;set;}
    
    public PatientRegisterVisitCtrl(ApexPages.StandardController ctrl) {
    	this.patient = (Contact)ctrl.getRecord();
        refresh();
    }
    
    public void refresh() {
        this.slots = [SELECT Id, Name, Start_Time__c, End_Time__c, Doctor__r.Name 
                   		FROM Appointment_Slot__c
                  	   WHERE Available__c = true];
    }
	
    public String registerSlotId {get;set;}
    
    public void register() {
        if (!String.isBlank(registerSlotId)) {
            Visit__c newVisit = new Visit__c(Appointment_Slot__c = registerSlotId, Patient__c = patient.Id);
            try {
	            insert newVisit;   
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Successfully registered for a visit!'));
                refresh();
            } catch (Exception ex) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error registering for a visit. Details: ' + ex.getMessage()));
                refresh();
            }
        }
    }
	
    
}

