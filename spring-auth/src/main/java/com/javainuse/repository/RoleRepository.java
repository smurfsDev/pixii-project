package com.javainuse.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.javainuse.entities.Role;

@EnableJpaRepositories
public interface RoleRepository extends JpaRepository<Role, Long> {
    @Query(" select u from Role u where u.name = ?1")
    Role findRoleWithName(String name);
}
