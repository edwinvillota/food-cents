package com.edwinvillota.food_cents.dtos;

import lombok.Data;

@Data
public class RegisterUserDto {
  private String username;
  private String email;
  private String password;
}
