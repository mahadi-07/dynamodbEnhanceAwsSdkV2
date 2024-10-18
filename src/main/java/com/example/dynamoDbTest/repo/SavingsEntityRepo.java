package com.example.dynamoDbTest.repo;

import com.example.dynamoDbTest.entity.SavingsAccountEntity;
import com.example.dynamoDbTest.model.AccountListWithPaginationRequest;
import com.example.dynamoDbTest.model.AccountListWithPaginationResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.core.pagination.sync.SdkIterable;
import software.amazon.awssdk.enhanced.dynamodb.*;
import software.amazon.awssdk.enhanced.dynamodb.model.Page;
import software.amazon.awssdk.enhanced.dynamodb.model.PageIterable;
import software.amazon.awssdk.enhanced.dynamodb.model.QueryConditional;
import software.amazon.awssdk.enhanced.dynamodb.model.QueryEnhancedRequest;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;

import java.util.*;

@Slf4j
@Service
public class SavingsEntityRepo {

    private final DynamoDbTable<SavingsAccountEntity> accountTableMapper;

    public SavingsEntityRepo(@Autowired DynamoDbEnhancedClient dynamoDbEnhancedClient) {
        this.accountTableMapper = dynamoDbEnhancedClient.table("dev-savings-account", TableSchema.fromBean(SavingsAccountEntity.class));
    }


    // save item
    // Puts a single item in the table.
    // If the table contains an item with the same primary key, it will be replaced with this item.
    public SavingsAccountEntity save(SavingsAccountEntity account) {
        accountTableMapper.putItem(account);
        return account;
    }

    // get single item
    // with hash-key and sort-key
    public SavingsAccountEntity getAccountByWalletIdAndSavingsId(String walletId, String savingsId) {
        return accountTableMapper.getItem(Key.builder()
                .partitionValue(walletId)
                .sortValue(savingsId)
                .build()
        );
    }

    public void queryReturnType(String walletId) {
        var queryConditional = QueryConditional
                .keyEqualTo(Key.builder().partitionValue(walletId)
                        .build()
                );

        // DynamoDbTable
        PageIterable<SavingsAccountEntity> accountEntityPageIterable = accountTableMapper.query(queryConditional);
        Page<SavingsAccountEntity> singlePage = accountTableMapper.query(queryConditional).stream().findFirst().orElse(null);
        SdkIterable<SavingsAccountEntity> sdkIterable = accountTableMapper.query(queryConditional).items();
        Iterator<Page<SavingsAccountEntity>> iterator = accountTableMapper.query(queryConditional).iterator();

        // get all the items in one call
        List<SavingsAccountEntity> listWay1 = accountTableMapper.query(queryConditional)
                .stream()
//                .flatMap(x -> x.items().stream())
                .map(Page::items)
                .flatMap(Collection::stream)
                .toList();

        List<SavingsAccountEntity> listWay2 = accountTableMapper.query(queryConditional)
                .items()
                .stream()
                .toList();

        // get only a single page items (first page of result)
        List<SavingsAccountEntity> singlePageItemsWay1 = accountTableMapper.query(queryConditional)
                .stream()
                .findFirst()
                .map(Page::items)
                .orElse(null);


        List<SavingsAccountEntity> singlePageItemsWay2 = accountTableMapper.query(queryConditional)
                .stream()
                .limit(1)
                .flatMap(x -> x.items().stream())
                .toList();

        // some other page (of the result)
        // ??? complete this
        List<SavingsAccountEntity> someOtherPageItems = accountTableMapper.query(queryConditional)
                .stream()
                .skip(1)
                .limit(1)
//                .flatMap(x -> x.items().stream())
                .map(Page::items)
                .flatMap(Collection::stream)
                .toList();


        // DynamodbIndex
        String rppSubscriptionRequestId = "5";
        DynamoDbIndex<SavingsAccountEntity> rppSubscriptionRequestIdGSI = accountTableMapper.index("gsi-rppSubscriptionRequestId");
        QueryConditional condition = QueryConditional
                .keyEqualTo(Key.builder().partitionValue(rppSubscriptionRequestId)
                        .build()
                );

        SdkIterable<Page<SavingsAccountEntity>> sdkIterable1 = rppSubscriptionRequestIdGSI.query(queryConditional);
        Iterator<Page<SavingsAccountEntity>> iterator1 = rppSubscriptionRequestIdGSI.query(queryConditional).iterator();
        Page<SavingsAccountEntity> page1 = rppSubscriptionRequestIdGSI.query(queryConditional).stream().findFirst().orElse(null);

        // get all items in one call

        // see the difference between this and listWay1 ?
        List<SavingsAccountEntity> list1 = rppSubscriptionRequestIdGSI.query(queryConditional)
                .stream()
//                .flatMap(x -> x.items().stream())
                .map(Page::items)
                .flatMap(Collection::stream)
                .toList();


    }

    // get multiple items
    // with hash-key

    // QueryConditional
    // This will return all the items with the same hash key.
        // sdk makes a single request to get all the data
        // but response is received in chunks, when the data is too large
        // finally return the full list
    public List<SavingsAccountEntity> getAccountsByWalletIdV1(String walletId) {

        QueryConditional queryConditional = QueryConditional
                .keyEqualTo(Key.builder().partitionValue(walletId)
                        .build()
                );


        accountTableMapper.query(queryConditional)
                .stream()
                .flatMap(x -> x.items().stream())
                .toList();


        PageIterable<SavingsAccountEntity> results = accountTableMapper.query(queryConditional);
        return results.items().stream().toList();
    }

    public AccountListWithPaginationResponse getAccountsWithPagination(AccountListWithPaginationRequest request) {

        Map<String, AttributeValue> lastEvaluatedKey = null;
        if(request.getLastEvaluatedKey() != null) {
            String[] lastEvaluatedKeyList = request.getLastEvaluatedKey().split("#");
            lastEvaluatedKey = Map.of(
                    "walletId", AttributeValue.builder().s(lastEvaluatedKeyList[0]).build(),
                    "savingsId", AttributeValue.builder().s(lastEvaluatedKeyList[1]).build()
            );
        }

        QueryEnhancedRequest queryEnhancedRequest = QueryEnhancedRequest.builder()
                .queryConditional(QueryConditional.keyEqualTo(Key.builder().partitionValue(request.getWalletId()).build()))
                .exclusiveStartKey(lastEvaluatedKey)
                .limit(request.getLimit())
                .build();

        PageIterable<SavingsAccountEntity> pageIterable = accountTableMapper.query(queryEnhancedRequest);

        AccountListWithPaginationResponse response = AccountListWithPaginationResponse.builder().build();

        pageIterable.stream().findFirst().ifPresent(page -> {
            if(Objects.nonNull(page.lastEvaluatedKey())) {
                Map<String, AttributeValue> lastedEvaluatedKey = page.lastEvaluatedKey();
                response.setLastEvaluatedKey(lastedEvaluatedKey.get("walletId").s() + "#" + lastedEvaluatedKey.get("savingsId").s());
            }
            response.setAccounts(page.items().stream().toList());
        });

        return response;
    }

    public List<SavingsAccountEntity> searchWithGSICalling(String rppSubscriptionRequestId) {

        DynamoDbIndex<SavingsAccountEntity> rppSubscriptionRequestIdGSI = accountTableMapper.index("gsi-rppSubscriptionRequestId");
        QueryConditional queryConditional = QueryConditional
                .keyEqualTo(Key.builder().partitionValue(rppSubscriptionRequestId)
                        .build()
                );
//
//        // this basically create a list of pointer
//        // how?
//            // I have no idea
//
//        // NOTE: this will not make any to the sdk, unless there is a call to the stream() method
//        SdkIterable<Page<SavingsAccountEntity>> sdkIterable = rppSubscriptionRequestIdGSI.query(
//                q -> q.queryConditional(queryConditional)
//                        .limit(12)
//        );
//
//        List<SavingsAccountEntity> list = new ArrayList<>();
//
//        // so pagination can be done with this
//        list = sdkIterable
//                .stream()
//                .limit(4) // this will limit the number of items we call the sdk
//                .flatMap(page -> page.items().stream())
//                .toList();
//
//        // so basically, we will get 12 * 4 = 48 items, in 4 calls we make to the sdk
//        return list;


        // as the DynamoDbIndex doesn't have .items() like PageIterable
        return rppSubscriptionRequestIdGSI.query(queryConditional)
                .stream()
                .flatMap(x -> x.items().stream())
                .toList();

    }


    public List<SavingsAccountEntity> searchWithGSI(String rppSubscriptionRequestId) {

        // this is important
        DynamoDbIndex<SavingsAccountEntity> rppSubscriptionRequestIdGSI = accountTableMapper.index("gsi-rppSubscriptionRequestId");
        QueryConditional queryConditional = QueryConditional
                .keyEqualTo(Key.builder().partitionValue(rppSubscriptionRequestId)
                        .build()
                );


        // notice we don't use accountTableMapper
        // we use rppSubscriptionRequestIdGSI


        // way - 1
        var list = rppSubscriptionRequestIdGSI.query(queryConditional)
                .stream()
                .flatMap(x -> x.items().stream())
                .toList();

        log.info("list = {}", list);
        log.info("list size = {}", list.size());

        // way - 2
        // we could use this way if we want to use pagination
        SdkIterable<Page<SavingsAccountEntity>> iterable = rppSubscriptionRequestIdGSI.query(queryConditional);
        iterable.stream().findFirst().ifPresent(page -> {
            log.info("page = {}", page);
            log.info("page items = {}", page.items());
            log.info("page lastEvaluatedKey = {}", page.lastEvaluatedKey());
        });


        // way - 3
        // pagination also can be implemented with this way
        Iterator<Page<SavingsAccountEntity>> iterable1 = rppSubscriptionRequestIdGSI.query(queryConditional).iterator();
        while(iterable1.hasNext()) {
            Page<SavingsAccountEntity> page = iterable1.next();
            log.info("page = {}", page);
            log.info("page items = {}", page.items());
            log.info("page lastEvaluatedKey = {}", page.lastEvaluatedKey());

        }
//        return rppSubscriptionRequestIdGSI.query(queryConditional).;
        return List.of();
    }



    public Optional<SavingsAccountEntity> searchWithLSI(String walletId, String fiAccountId) {
        DynamoDbIndex<SavingsAccountEntity> fiAccountIdLSIMapper = accountTableMapper.index("lsi-fiAccountId");

        QueryConditional condition = QueryConditional
                .keyEqualTo(Key.builder().partitionValue(walletId)
                        .sortValue(fiAccountId)
                        .build()
                );

        return fiAccountIdLSIMapper.query(condition)
                .stream()
                .flatMap(x -> x.items().stream())
                .findFirst();
    }

    public List<SavingsAccountEntity> getAccountsByWalletIdV2(String walletId) {



        Map<String, AttributeValue> lastEvaluatedKey = Map.of(
                "walletId", AttributeValue.builder().s(walletId).build(),
                "savingsId", AttributeValue.builder().s("5").build()
        );

        QueryEnhancedRequest queryEnhancedRequest = QueryEnhancedRequest.builder()
                .queryConditional(QueryConditional.keyEqualTo(Key.builder().partitionValue(walletId).build()))
                .exclusiveStartKey(lastEvaluatedKey)
                .limit(5)  // Limit the number of items per page
                .build();

        // Execute the query to get a paginated result
        PageIterable<SavingsAccountEntity> result = accountTableMapper.query(queryEnhancedRequest);
        return List.of();
    }


    // this will not work as dynamodb doesn't support querying across multiple partition keys
    // will only result for partition key = 20241017
        // will ignore 20241018 and 20241019
    public void thisWouldNotWork() {
        DynamoDbIndex<SavingsAccountEntity> startShortDateCurrentDateGSI = accountTableMapper.index("gsi-startShortDate-currentState");
        QueryConditional condition = QueryConditional
                .sortBetween(
                        Key.builder().partitionValue("20241017").sortValue("DELETED_STATUS").build(),
                        Key.builder().partitionValue("20241019").sortValue("STATUS_INIT").build()
                );

        startShortDateCurrentDateGSI.query(condition).stream().flatMap(x -> x.items().stream()).toList();
    }


    public List<SavingsAccountEntity> useOfGreaterThanOrEqualEtcInSortKey() {
        DynamoDbIndex<SavingsAccountEntity> maturityShortDateIndex = accountTableMapper.index("gsi-startShortDate-currentState");
        QueryConditional condition = QueryConditional
                .sortBetween(
                        // this will work just fine as, partition key is same
                        Key.builder().partitionValue("1").sortValue("10001").build(),
                        Key.builder().partitionValue("1").sortValue("10005").build()
                );

        return maturityShortDateIndex.query(q -> q
                        .queryConditional(condition)
                        .limit(3)
                )
                .stream()
                .map(Page::items)
                .flatMap(Collection::stream)
                .toList();

    }


    public void testCallCount() {
        QueryConditional queryConditional = QueryConditional
                .keyEqualTo(Key.builder().partitionValue("1")
                        .build()
                );


        PageIterable<SavingsAccountEntity> pageIterable = accountTableMapper.query(q -> q.queryConditional(queryConditional).limit(12));


        List<SavingsAccountEntity> list = pageIterable.items().stream().toList();
        log.info("list = {}", list);
        log.info("list size = {}", list.size());


//        // this will make 3 calls to the sdk
//        List<SavingsAccountEntity> someOtherPageItems = accountTableMapper.query(q -> q.queryConditional(queryConditional).limit(12))
//                .stream()
//                .skip(1)
//                .limit(2)
//                .flatMap(x -> x.items().stream())
//                .toList();
//
//        log.info("someOtherPageItems = {}", someOtherPageItems);
//        log.info("someOtherPageItems size = {}", someOtherPageItems.size());
    }
}
