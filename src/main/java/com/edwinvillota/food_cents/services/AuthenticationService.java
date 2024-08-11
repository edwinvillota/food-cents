package com.edwinvillota.food_cents.services;

import com.edwinvillota.food_cents.dtos.LoginUserDto;
import com.edwinvillota.food_cents.dtos.RegisterUserDto;
import com.edwinvillota.food_cents.entities.User;

public interface AuthenticationService {
  User signUp(RegisterUserDto input);

  User authenticate(LoginUserDto input);
}
