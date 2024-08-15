package com.edwinvillota.food_cents.services.impl;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.edwinvillota.food_cents.entities.Category;
import com.edwinvillota.food_cents.repositories.CategoryRepository;
import com.edwinvillota.food_cents.services.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

  private final CategoryRepository categoryRepository;

  public CategoryServiceImpl(CategoryRepository categoryRepository) {
    this.categoryRepository = categoryRepository;
  }

  @Override
  public Page<Category> findAll(Pageable pageable) {
    return categoryRepository.findAll(pageable);
  }

}
