package com.edwinvillota.food_cents.services.impl;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.edwinvillota.food_cents.dtos.LoginUserDto;
import com.edwinvillota.food_cents.dtos.RegisterUserDto;
import com.edwinvillota.food_cents.entities.User;
import com.edwinvillota.food_cents.repositories.UserRepository;
import com.edwinvillota.food_cents.services.AuthenticationService;

@Service
public class AuthenticationServiceImpl implements AuthenticationService {
  private final UserRepository userRepository;
  private final PasswordEncoder passwordEncoder;
  private final AuthenticationManager authenticationManager;

  public AuthenticationServiceImpl(
      UserRepository userRepository,
      AuthenticationManager authenticationManager,
      PasswordEncoder passwordEncoder) {
    this.authenticationManager = authenticationManager;
    this.userRepository = userRepository;
    this.passwordEncoder = passwordEncoder;
  }

  @Override
  public User signUp(RegisterUserDto input) {
    User user = new User()
        .setEmail(input.getEmail())
        .setUsername(input.getUsername())
        .setPassword(passwordEncoder.encode(input.getPassword()));

    return userRepository.save(user);
  }

  @Override
  public User authenticate(LoginUserDto input) {
    authenticationManager.authenticate(
        new UsernamePasswordAuthenticationToken(input.getEmail(), input.getPassword()));

    return userRepository.findByEmail(input.getEmail()).orElseThrow();
  }

}
