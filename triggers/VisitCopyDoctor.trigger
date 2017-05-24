trigger VisitCopyDoctor on Visit__c (before insert, before update) {

    Set<Id> slotIds = new Set<Id>();
    
    for (Visit__c visit : Trigger.new) {
        slotIds.add(visit.Appointment_Slot__c);
    }
    
    Map<Id, Appointment_Slot__c> slotMap = new Map<Id, Appointment_Slot__c>([SELECT Id, Doctor__c 
                                                                               FROM Appointment_Slot__c
                                                                              WHERE Id IN :slotIds]);
    for (Visit__c visit : Trigger.new) {
        visit.Doctor__c = slotMap.get(visit.Appointment_Slot__c).Doctor__c;
    }
}
