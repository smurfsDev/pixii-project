package com.javainuse.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.javainuse.entities.User;

@EnableJpaRepositories
public interface UserRepository extends JpaRepository<User, Integer> {

	Optional<User> findByUsername(String username);

	public User findByVerificationCode(String code);

	public User findByEmail(String email);

	@Query("SELECT u FROM User u WHERE u.email = ?1")
	Optional<User> findUserByEmail(String email);

	// list of users and their roles pivot table
	@Query("SELECT ru FROM User u JOIN UserRole ru ON u.id = ru.user.id Join Role r ON ru.role.id = r.id")
	List<Object[]> findUserAndRole();
}
