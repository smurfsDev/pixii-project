package com.javainuse.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.javainuse.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
    @Query(" select u from User u where u.username = ?1")
    Optional<User> findUserWithName(String username);
}
