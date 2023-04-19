/**
 * Created by eva.lopez on 12/04/2023.
 */

public with sharing class ChatControllerEnviar {
    @AuraEnabled
    public static void enviarMensaje(String texto) {
        Mensaje__c msgNew = new Mensaje__c(Name = 'yo',From__c = 'yo', Body__c = texto, Recieved__c = false);
        insert msgNew;
    }
}