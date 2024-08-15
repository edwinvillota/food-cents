package com.edwinvillota.food_cents.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.edwinvillota.food_cents.entities.Category;

public interface CategoryService {
  Page<Category> findAll(Pageable pageable);
}
