package com.example.dynamoDbTest.entity;

import com.example.dynamoDbTest.model.CurrentState;
import com.example.dynamoDbTest.model.CurrentStatusConverter;
import lombok.*;
import software.amazon.awssdk.enhanced.dynamodb.mapper.annotations.*;

import java.io.Serializable;

@ToString

// if we use Builder annotation, we need to add @AllArgsConstructor and @NoArgsConstructor
// this article suggest not no use Builder pattern: https://serhatcan.medium.com/how-to-migrate-from-dynamodb-java-sdk-v1-to-v2-2e3660729e05
    // Important: While creating entity objects, don’t create setters using the Builder pattern.
    // I don’t exactly know why and if they will fix it but “return this;” doesn’t work with SDK v2 automated object mapping.
    // Use regular getter and setter methods — not builder patterned setters.

@Builder
@NoArgsConstructor
@AllArgsConstructor

@Setter

@DynamoDbBean
public class SavingsAccountEntity implements Serializable {

    // we need to define getter for each field manually
    // for setter method we could use @Data or @Setter annotation
        // without setter method, while trying to save data into table
            // java.lang.IllegalArgumentException: Attempt to execute an operation that requires a primary index without
            // defining any primary key attributes in the table metadata.

    private String walletId;
    private String savingsId;

    private String rppSubscriptionRequestId;

    private String maturityShortDate;

    private String fiAccountId;

    private String startShortDate;
    private CurrentState currentState;

    @DynamoDbPartitionKey
    @DynamoDbSecondaryPartitionKey(indexNames = {"lsi-fiAccountId"})
    public String getWalletId() {
        return walletId;
    }

    @DynamoDbSecondaryPartitionKey(indexNames = {"gsi-startShortDate-currentState"})
    public String getStartShortDate() {
        return startShortDate;
    }

    @DynamoDbSecondarySortKey(indexNames = {"gsi-startShortDate-currentState"})
    @DynamoDbConvertedBy(CurrentStatusConverter.class)
    public CurrentState getCurrentState() {
        return currentState;
    }

//    public void setWalletId(String walletId) {
//        this.walletId = walletId;
//    }

    @DynamoDbSortKey
    public String getSavingsId() {
        return savingsId;
    }

//    public void setSavingsId(String savingsId) {
//        this.savingsId = savingsId;
//    }

    @DynamoDbSecondaryPartitionKey(indexNames = {"gsi-rppSubscriptionRequestId"})
    public String getRppSubscriptionRequestId() {
        return rppSubscriptionRequestId;
    }

    @DynamoDbSecondarySortKey(indexNames = {"lsi-fiAccountId"})
    public String getFiAccountId() {
        return fiAccountId;
    }

    @DynamoDbSecondaryPartitionKey(indexNames = {"gsi-maturityShortDate"})
    public String getMaturityShortDate() {
        return maturityShortDate;
    }
}
