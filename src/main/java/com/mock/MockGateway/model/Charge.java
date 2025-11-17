package com.mock.MockGateway.model;

import java.math.BigDecimal;

public record Charge(
        Integer Id,
        String description,
        BigDecimal amount
) { }
