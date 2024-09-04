package com.example.current.time.service;

import com.example.current.time.exception.InvalidTimeZoneException;
import org.springframework.stereotype.Service;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.zone.ZoneRulesException;

@Service
public class TimeService {

    public String getCurrentTime(String timezone) {
        try {
            ZoneId zoneId = ZoneId.of(timezone);
            ZonedDateTime currentTime = ZonedDateTime.now(zoneId);

            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
            String formattedDate = currentTime.format(dateFormatter);
            String formattedTime = currentTime.format(timeFormatter);
            String timeZoneOffset = currentTime.getOffset().getId();

            return String.format("{\"date\":\"%s\", \"time\":\"%s\", \"timezone\":\"%s\"}", formattedDate, formattedTime, timeZoneOffset);
        } catch (ZoneRulesException e) {
            throw new InvalidTimeZoneException("Invalid timezone provided: " + timezone);
        }
    }
}
