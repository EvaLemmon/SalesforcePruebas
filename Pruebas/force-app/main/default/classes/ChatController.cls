/*
 * Created by eva.lopez on 12/04/2023.
 */

public with sharing class ChatController {
    /*@AuraEnabled(Cacheable=true)
    public static List<Mensaje__c> getMensajes(String id) {
        List<Mensaje__c> mensajesDeContacto = new List<Mensaje__c>();
        Set<String> contactPhones = new Set<String>();
        for (Contact c : [SELECT Phone FROM Contact]) {
            contactPhones.add(c.Phone);
        }

        List<Mensaje__c> mensajes = [SELECT Recieved__c, Name, From__c, Body__c, CreatedDate, To__c
        FROM Mensaje__c
        WHERE To__c IN :contactPhones OR To__c = 'yo'
        ORDER BY CreatedDate ASC];

        return mensajes;
    } */

    @AuraEnabled(Cacheable=true)
    public static Map<String, Object> getContactInfo(String recordId) {

        Map<String, Object> map_ret = new Map<String, Object>();
        Contact c = [SELECT LastName, Phone FROM Contact WHERE Id =: recordId LIMIT 1];
         if(c.Phone!=null){
             map_ret.put('lstMessages',
                     [SELECT Name, To__c, From__c, Body__c, Recieved__c, CreatedDate FROM Mensaje__c
                     WHERE From__c = :c.Phone OR To__c = :c.Phone OR From__c = 'yo' ORDER BY CreatedDate ASC]);
         map_ret.put('c', c);
         }
         System.debug(map_ret.get('lstMessages'));
         return map_ret;
    }

    @AuraEnabled
    public static Boolean enviarMensaje(String mensajeaenviar) {
        try {
            System.debug(mensajeaenviar);

            System.debug(Mensaje__c.class.toString());
        Mensaje__c msgNew = (Mensaje__c) JSON.deserialize(mensajeaenviar, Mensaje__c.class);
        insert msgNew;
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @AuraEnabled(Cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, Phone, Name, hasChat__c FROM Contact WHERE hasChat__c = true];
    }
}