package com.example.dynamoDbTest;

import com.example.dynamoDbTest.entity.SavingsAccountEntity;
import com.example.dynamoDbTest.model.AccountListWithPaginationRequest;
import com.example.dynamoDbTest.model.CurrentState;
import com.example.dynamoDbTest.repo.SavingsEntityRepo;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.List;

@Slf4j
@SpringBootTest
@TestPropertySource(properties = "logging.level.root=DEBUG")
public class SavingsAccountTableTest {

    @Autowired
    private SavingsEntityRepo savingsEntityRepo;


    @Test
    public void createAccounts() {
        String[] dataList = {"20241017", "20241018", "20241019"};
        CurrentState[] dataList2 = {CurrentState.STATUS_1, CurrentState.STATUS_INIT, CurrentState.DELETED_STATUS};
        int n = 10;
        for(int i=0; i<n; i++){
            SavingsAccountEntity account = SavingsAccountEntity.builder()
                    .walletId(String.valueOf(1))
                    .savingsId(String.valueOf(i))
                    .rppSubscriptionRequestId("5")
                    .fiAccountId(String.valueOf(i + 10000))
                    .maturityShortDate(dataList[i%3])
                    .startShortDate(dataList[i%2])
                    .currentState(dataList2[i%3])
                    .build();

            savingsEntityRepo.save(account);
        }
    }

    @Test
    public void getAccountByWalletIdAndSavingsIdTest() {

        String walletId = "1";
        String savingsId = "1";

        var response =  savingsEntityRepo.getAccountByWalletIdAndSavingsId(walletId, savingsId);
        log.info("response = {}", response);
    }

    @Test
    public void getMultipleItemV1ByPartitionKey() throws IOException {
        String walletId = "1"; // which is our hash key
        var responseList = savingsEntityRepo.getAccountsByWalletIdV1(walletId);
        log.info("responseList.size() = {}", responseList.size());
        double sizeInKB = calculateListSizeInKB(responseList);
        log.info("sizeInKB = {}", sizeInKB);
    }

    @Test
    public void getMultipleItemV2ByPartitionKey() throws IOException {
        String walletId = "1";
        var responseListV2 = savingsEntityRepo.getAccountsByWalletIdV2(walletId);
//        log.info("responseListV2.size() = {}", responseListV2.size());
//        log.info("responseListV2 sizeInKB = {}", calculateListSizeInKB(responseListV2));
    }

    @Test
    public void getAccountsWithPaginationTest() {
        String walletId = "1";

        String lastEvaluatedKey = null;
        var request = AccountListWithPaginationRequest.builder()
                .walletId(walletId)
                .lastEvaluatedKey(lastEvaluatedKey)
                .limit(12)
                .build();

        do {

            var response = savingsEntityRepo.getAccountsWithPagination(request);
            log.info("response items size = {}", response.getAccounts().size());


//            response.getAccounts().forEach(account -> {
//                log.info(account.toString());
//            });
            log.info("\n\n\n");
            request.setLastEvaluatedKey(response.getLastEvaluatedKey());

        } while (request.getLastEvaluatedKey() != null);
    }

    @Test
    public void searchWithGSI() {
        List<SavingsAccountEntity> list = savingsEntityRepo.searchWithGSI("10");
        log.info("list = {}", list);
    }

    @Test
    public void searchWithLSI() {
        var optionalAccount = savingsEntityRepo.searchWithLSI("1", "1000");
        log.info("optionalAccount = {}", optionalAccount);
        optionalAccount.ifPresent(account -> {
            log.info("account = {}", account);
        });
    }


    @Test
    public void searchWithGSICallingTest() {
        List<SavingsAccountEntity> list = savingsEntityRepo.searchWithGSICalling("5");
        log.info("list = {}", list);
        log.info("size = {}", list.size());
    }

    public static double calculateListSizeInKB(List<?> list) throws IOException {
        // Serialize the list to a byte array
        ByteArrayOutputStream byteOutputStream = new ByteArrayOutputStream();
        ObjectOutputStream objectOutputStream = new ObjectOutputStream(byteOutputStream);

        objectOutputStream.writeObject(list);
        objectOutputStream.flush();

        // Calculate the size in bytes
        int sizeInBytes = byteOutputStream.size();

        // Convert bytes to kilobytes
        double sizeInKB = sizeInBytes / 1024.0;

        // Close streams
        objectOutputStream.close();
        byteOutputStream.close();

        return sizeInKB;
    }

    @Test
    public void useOfGreaterThanOrEqualEtcInSortKeyTest() {
        List<SavingsAccountEntity> list = savingsEntityRepo.useOfGreaterThanOrEqualEtcInSortKey();
        log.info("list size {}", list.size());
        list.forEach(account -> log.info(account.toString()));
    }

    @Test
    public void testCallCountTest() {
        savingsEntityRepo.testCallCount();
    }
}
