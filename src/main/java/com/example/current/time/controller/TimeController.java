package com.example.current.time.controller;

import com.example.current.time.exception.InvalidTimeZoneException;
import com.example.current.time.service.TimeService;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/time")
public class TimeController {

    private final TimeService timeService;

    public TimeController(TimeService timeService) {
        this.timeService = timeService;
    }

    @GetMapping
    public ResponseEntity<String> getCurrentTime(
            @RequestParam(value = "timezone", defaultValue = "UTC") String timezone) {
        try {
            String currentTime = timeService.getCurrentTime(timezone);
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(currentTime);
        } catch (InvalidTimeZoneException e) {
            return ResponseEntity.badRequest()
                    .body("{\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}
