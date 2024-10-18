package com.example.dynamoDbTest.model;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AccountListWithPaginationRequest {

    private String walletId;
    private String lastEvaluatedKey;
    private int limit;
}
