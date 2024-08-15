package com.edwinvillota.food_cents.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.edwinvillota.food_cents.entities.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
}
