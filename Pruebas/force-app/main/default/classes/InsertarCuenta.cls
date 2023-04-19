public class InsertarCuenta {
    public static Account insertarCuentaNueva(String s1, String s2){

try{
        Account accountObj = new Account();
        accountObj.name = s1;
        accountObj.CIF__c = s2;
        insert accountObj;  
        return accountObj;
   }
Catch(DMLException de){

        return null;

       }
}

}