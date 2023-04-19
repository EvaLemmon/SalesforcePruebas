/**
 * Created by eva.lopez on 29/03/2023.
 */

public abstract class TriggerHandler {
    public virtual void bulkBefore() { }
    public virtual void bulkAfter() { }
/* BEFORE */
    public virtual void beforeInsert(List<SObject> newRecords_List) { }
    public virtual void beforeUpdate(Map<Id, SObject> oldRecords_Map, List<SObject> newRecords_List) { }
    public virtual void beforeDelete(Map<Id, SObject> oldRecords_Map) { }
/* / BEFORE */
/* AFTER */
    public virtual void afterInsert(List<SObject> newRecords_List) { }
    public virtual void afterUpdate(Map<Id, SObject> oldRecords_Map, List<SObject> newRecords_List) { }
    public virtual void afterDelete(Map<Id, SObject> oldRecords_Map) { }
    public virtual void afterUndelete(Map<Id, SObject> oldRecords_Map) { }
/* / AFTER */
    public virtual void andFinally() { }
}