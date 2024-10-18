package com.example.dynamoDbTest.model;

public enum CurrentState {

    STATUS_1("ACTIVE"),
    STATUS_INIT("INACTIVE"),
    DELETED_STATUS("DELETED");

    private String status;

    CurrentState(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }
}
