/**
 * Created by eva.lopez on 29/03/2023.
 */

public class AccountTriggerHandler extends TriggerHandler {
    public override void beforeInsert(List<SObject> newRecords_List) {
        List<Account> cuentas = (List<Account>) newRecords_List;
        for(Account cuenta : cuentas){
            if(String.isBlank(cuenta.Ownership)){
                cuenta.Ownership = 'No se';
            }
        }
    }
/*
    public override void beforeUpdate(Map<Id, SObject> oldRecords_Map, List<SObject> newRecords_List) { }
    public override void beforeDelete(Map<Id, SObject> oldRecords_Map) { }
    public override void afterInsert(List<SObject> newRecords_List) { }
    public override void afterUpdate(Map<Id, SObject> oldRecords_Map, List<SObject> newRecords_List) { }
    public override void afterDelete(Map<Id, SObject> oldRecords_Map) { }
    public override void afterUndelete(Map<Id, SObject> oldRecords_Map) { }
*/
}