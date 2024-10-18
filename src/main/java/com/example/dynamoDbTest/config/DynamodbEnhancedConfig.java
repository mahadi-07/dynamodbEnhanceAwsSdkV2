package com.example.dynamoDbTest.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.AwsCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.client.config.ClientOverrideConfiguration;
import software.amazon.awssdk.enhanced.dynamodb.DynamoDbEnhancedClient;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;

import java.net.URI;

@Configuration
public class DynamodbEnhancedConfig {

    @Bean
    DynamoDbClient amazonDynamoDBClient() {
        return getDynamoDbClient();
    }

    @Bean
    DynamoDbEnhancedClient amazonDynamoDBEnhancedClient() {
        return DynamoDbEnhancedClient.builder().dynamoDbClient(getDynamoDbClient()).build();
    }

    private DynamoDbClient getDynamoDbClient() {
        ClientOverrideConfiguration.Builder overrideConfig =
                ClientOverrideConfiguration.builder();

        AwsCredentials credentials = AwsBasicCredentials.create("fakeMyKeyId", "fakeSecretAccessKey");

        return DynamoDbClient.builder()
                .overrideConfiguration(overrideConfig.build())
                .endpointOverride(URI.create("http://localhost:4566"))
                .region(Region.AP_SOUTHEAST_1)
                .credentialsProvider(StaticCredentialsProvider.create(credentials))
                .build();
    }
}
