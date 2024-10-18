package com.example.dynamoDbTest.model;

import com.example.dynamoDbTest.entity.SavingsAccountEntity;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class AccountListWithPaginationResponse {

    List<SavingsAccountEntity> accounts;

    String lastEvaluatedKey;
}
