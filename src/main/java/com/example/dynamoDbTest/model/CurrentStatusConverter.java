package com.example.dynamoDbTest.model;

import software.amazon.awssdk.enhanced.dynamodb.AttributeConverter;
import software.amazon.awssdk.enhanced.dynamodb.AttributeValueType;
import software.amazon.awssdk.enhanced.dynamodb.EnhancedType;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;

public class CurrentStatusConverter implements AttributeConverter<CurrentState> {

    @Override
    public AttributeValue transformFrom(CurrentState input) {
        // Convert the enum to a String for storage in DynamoDB
        return AttributeValue.builder().s(input.name()).build();
    }

    @Override
    public CurrentState transformTo(AttributeValue attributeValue) {
        // Convert the stored String back to the enum
        return CurrentState.valueOf(attributeValue.s());
    }

    @Override
    public EnhancedType<CurrentState> type() {
        return EnhancedType.of(CurrentState.class);
    }

    @Override
    public AttributeValueType attributeValueType() {
        return AttributeValueType.S;
    }
}
