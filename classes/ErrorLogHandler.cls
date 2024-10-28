/**
 * Created by Aliaksandr Vabishchevich 28.10.24.
 */

public with sharing class ErrorLogHandler {
    public static void createErrorLog(String className, String errorMessage) {
        insert new Error_Log__c(
                Error_Log__c = errorMessage,
                Class_Name__c = className,
                Exception_Time__c = Datetime.now()
        );
    }

}