package com.javainuse.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.javainuse.entities.ResetPassword;

@EnableJpaRepositories
public interface ResetPasswordRepository extends JpaRepository<ResetPassword, Long>{
    ResetPassword findByEmail(String email);
}
