package com.edwinvillota.food_cents.services.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.edwinvillota.food_cents.entities.User;
import com.edwinvillota.food_cents.repositories.UserRepository;
import com.edwinvillota.food_cents.services.UserService;

@Service
public class UserServiceImpl implements UserService {

  private final UserRepository userRepository;

  public UserServiceImpl(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  @Override
  public List<User> findAll() {
    return userRepository.findAll();
  }

}
