package com.edwinvillota.food_cents.controllers;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.edwinvillota.food_cents.entities.Category;
import com.edwinvillota.food_cents.services.CategoryService;

@RequestMapping("/api/v1/category")
@RestController
public class CategoryController {

  private final CategoryService categoryService;

  public CategoryController(CategoryService categoryService) {
    this.categoryService = categoryService;
  }

  @GetMapping("/all")
  public ResponseEntity<Page<Category>> findAll(@RequestParam(name = "page", defaultValue = "0") int page,
      @RequestParam(name = "size", defaultValue = "10") int size) {
    Pageable pageable = PageRequest.of(page, size);

    return ResponseEntity.ok(categoryService.findAll(pageable));
  }

}
