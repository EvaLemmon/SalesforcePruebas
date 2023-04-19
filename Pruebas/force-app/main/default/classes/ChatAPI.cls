/**
 * Created by eva.lopez on 12/04/2023.
 */
@RestResource(UrlMapping='/message')
global with sharing class ChatAPI {
    @HttpPost
    global static void getMessage() {
        RestRequest req = RestContext.request!=null?RestContext.request:new RestRequest();
        RestResponse res = RestContext.response!=null?RestContext.response:new RestResponse();

        res.addHeader( 'Content-Type' , 'application/json');
        Error errRes = new Error();
        try{
            String jsonMsgWrapper = req.requestBody != null ? req.requestBody.toString().trim() : '';
            System.debug(jsonMsgWrapper);
            ChatAPI.msgObj msg = (msgObj)JSON.deserialize(jsonMsgWrapper, ChatAPI.msgObj.class);

            Mensaje__c msgNew = new Mensaje__c(Name = msg.name ,From__c = msg.phone, Body__c = msg.msgBody, To__c = msg.to, Recieved__c = true);
            Message__e msgEvent = new Message__e(Name__c = msg.name ,From__c = msg.phone, Body__c = msg.msgBody, To__c = msg.to, Recieved__c = true);
            EventBus.publish(msgEvent);
            List<Contact> lstContact = [SELECT Name, Phone,hasChat__c FROM Contact WHERE Phone =: msg.to LIMIT 1];
            if(lstContact.isEmpty()){
                Contact c = new Contact (LastName = msg.name, Phone = msg.to, hasChat__c = true);
                insert c;
            }else{
                if(!lstContact[0].hasChat__c) {
                    lstContact[0].hasChat__c = true;
                    update lstContact[0];
                }
            }
            insert msgNew;
        } catch (Exception exc) {
            System.debug(exc.getMessage()); errRes.error = true; errRes.message = exc.getMessage(); } res.responseBody = Blob.valueOf(JSON.serialize(errRes));


    }

    public class Error { public Boolean error; public String message; public Error(){ this.error = false; this.message = 'OK'; } public Error(Boolean error, String message){ this.error = error; this.message = message; } }

     class msgObj{
         private String name;
         private String phone;
         private String msgBody;
         private Boolean recieved;
         private String to;

         msgObj(String name, String phone, String msgBody, Boolean recieved, String to){
             this.name = name;
             this.phone = phone;
             this.msgBody = msgBody;
             this.recieved = recieved;
             this.to = to;
         }
     }
}