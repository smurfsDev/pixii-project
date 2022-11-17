package com.javainuse.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.javainuse.entities.User;

@EnableJpaRepositories
public interface UserRepository extends JpaRepository<User, Integer> {
    @Query(" select u from User u where u.username = ?1")
    Optional<User> findUserWithName(String username);

    // @Query(" select u from User u where u.email = ?1")
    // User findUserWithEmail(String email);
}
