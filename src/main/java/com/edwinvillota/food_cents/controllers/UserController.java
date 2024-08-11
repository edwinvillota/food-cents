package com.edwinvillota.food_cents.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edwinvillota.food_cents.entities.User;

@RequestMapping("/api/v1/user")
@RestController
public class UserController {

  @GetMapping("/me")
  public ResponseEntity<User> authenticatedUser() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

    User currentUser = (User) authentication.getPrincipal();

    return ResponseEntity.ok(currentUser);

  }
}
