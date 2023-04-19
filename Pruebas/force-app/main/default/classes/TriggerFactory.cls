/**
 * Created by eva.lopez on 29/03/2023.
 */

public class TriggerFactory {
    public static void execute(String objectName) {
        TriggerHandler t;
        //TriggersManager.disableTrigger(objectName);
        if(TriggersManager.canExecuteTrigger(objectName)){
            Map<String, Object> mapaObjetos = new Map<String, Object>{'Account' => new AccountTriggerHandler()};
            t = (TriggerHandler) mapaObjetos.get(objectName);
            LanzarCodigo(t);
        }
    }

private static void LanzarCodigo(TriggerHandler t) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            t.beforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE {
            t.beforeUpdate(Trigger.oldMap, Trigger.new);
        }
        when BEFORE_DELETE {
            t.beforeDelete(Trigger.oldMap);
        }
        when AFTER_INSERT {
            t.afterInsert(Trigger.new);
        }
        when AFTER_UPDATE {
            t.afterUpdate(Trigger.oldMap, Trigger.new);
        }
        when AFTER_DELETE {
            t.afterDelete(Trigger.oldMap);
        }
        when AFTER_UNDELETE {
            t.afterUndelete(Trigger.oldMap);
        }
    }
}
}