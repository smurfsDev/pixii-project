package com.javainuse.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.javainuse.entities.Role;
import com.javainuse.entities.UserRole;

@EnableJpaRepositories
public interface UserRoleRepository extends JpaRepository<UserRole, Integer> {

    Optional<UserRole> findFirstByUserId(int userId);

    List<UserRole> findAllByStatus(int i);

}
