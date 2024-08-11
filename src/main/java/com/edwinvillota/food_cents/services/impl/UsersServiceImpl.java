package com.edwinvillota.food_cents.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edwinvillota.food_cents.entities.User;
import com.edwinvillota.food_cents.repositories.UserRepository;
import com.edwinvillota.food_cents.services.UsersService;

@Service
public class UsersServiceImpl implements UsersService {

  @Autowired
  private UserRepository userRepository;

  @Override
  public List<User> findAll() {
    return userRepository.findAll();
  }

}
