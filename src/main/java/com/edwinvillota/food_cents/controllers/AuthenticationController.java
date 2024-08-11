package com.edwinvillota.food_cents.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edwinvillota.food_cents.dtos.LoginResponse;
import com.edwinvillota.food_cents.dtos.LoginUserDto;
import com.edwinvillota.food_cents.dtos.RegisterUserDto;
import com.edwinvillota.food_cents.entities.User;
import com.edwinvillota.food_cents.services.AuthenticationService;
import com.edwinvillota.food_cents.services.JwtService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RequestMapping("/api/v1/auth")
@RestController
public class AuthenticationController {

  private final JwtService jwtService;
  private final AuthenticationService authenticationService;

  public AuthenticationController(JwtService jwtService, AuthenticationService authenticationService) {
    this.jwtService = jwtService;
    this.authenticationService = authenticationService;
  }

  @PostMapping("/signup")
  public ResponseEntity<User> register(@RequestBody RegisterUserDto registerUserDto) {
    User registeredUser = authenticationService.signUp(registerUserDto);

    return ResponseEntity.ok(registeredUser);
  }

  @PostMapping("/login")
  public ResponseEntity<LoginResponse> authenticate(@RequestBody LoginUserDto loginUserDto) {
    User authenticatedUser = authenticationService.authenticate(loginUserDto);

    String jwtToken = jwtService.generateToken(authenticatedUser);

    LoginResponse loginResponse = new LoginResponse()
        .setToken(jwtToken)
        .setExpiresIn(jwtService.getExpirationTime());

    return ResponseEntity.ok(loginResponse);
  }

}
