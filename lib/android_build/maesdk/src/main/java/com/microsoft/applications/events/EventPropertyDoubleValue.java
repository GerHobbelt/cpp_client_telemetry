//
// Copyright (c) Microsoft Corporation. All rights reserved.
// SPDX-License-Identifier: Apache-2.0
//
package com.microsoft.applications.events;

public class EventPropertyDoubleValue extends EventPropertyValue{
    private double m_value;

    public EventPropertyDoubleValue(final double value) {
        super(EventPropertyType.TYPE_DOUBLE);
        m_value = value;
    }

    @Override
    public double getDouble() {
        return m_value;
    }
}

