package com.example.dynamoDbTest;

import com.example.dynamoDbTest.entity.SavingsAccountEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import software.amazon.awssdk.enhanced.dynamodb.TableSchema;

@Slf4j
@SpringBootApplication
public class DynamoDbTestApplication {

	public static void main(String[] args) {
		System.setProperty("logging.level.software.amazon.awssdk", "TRACE");
		SpringApplication.run(DynamoDbTestApplication.class, args);
		log.info("DynamoDbTestApplication started");
	}


	CommandLineRunner runner = new CommandLineRunner() {

		@Override
		public void run(String... args) throws Exception {
			// TODO Auto-generated method stub

		}
	};

}
