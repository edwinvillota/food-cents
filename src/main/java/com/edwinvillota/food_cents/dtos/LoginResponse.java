package com.edwinvillota.food_cents.dtos;

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Accessors(chain = true)
@Getter
@Setter
public class LoginResponse {

  private String token;
  private long expiresIn;

  public String getToken() {
    return token;
  }
}
