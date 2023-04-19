/**
 * Created by eva.lopez on 29/03/2023.
 */

public class TriggersManager {

    private static Map<String, Boolean> mapa = new Map<String, Boolean>();

    public static void disableTrigger(String objectName) {
        mapa.put(objectName, false);
    }

    public static void enableTrigger(String objectName) {
        mapa.put(objectName, true);
    }

    public static Boolean canExecuteTrigger(String objectName) {
        return mapa.containsKey(objectName) ? mapa.get(objectName): true;
    }
}