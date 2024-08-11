package com.edwinvillota.food_cents.exceptions;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

@RestControllerAdvice
public class GlobalExceptionHandler {
  @ExceptionHandler(Exception.class)
  public ResponseEntity<Object> handleAllExceptions(Exception exception, WebRequest request) {
    Map<String, Object> body = new HashMap<>();

    body.put("timestamp", LocalDateTime.now());
    body.put("status", HttpStatus.UNAUTHORIZED.value());
    body.put("error", "Unauthorized");
    body.put("message",
        "Access denied: Authentication is required and has failed or has not yet been provided. Please ensure your request includes a valid authentication token.");
    body.put("path", request.getDescription(false).replace("uri=", ""));

    return new ResponseEntity<>(body, HttpStatus.UNAUTHORIZED);
  }
}
