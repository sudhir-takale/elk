package com.example.observability.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class SampleService {

    private static final Logger logger = LoggerFactory.getLogger(SampleService.class);

    public String processTransaction() {
        logger.info("Processing transaction for user {}", UUID.randomUUID());
        return "Transaction completed";
    }
}

