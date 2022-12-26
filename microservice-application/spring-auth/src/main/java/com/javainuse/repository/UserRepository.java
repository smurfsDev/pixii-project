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

	@Query("SELECT u,ru.status FROM User u JOIN UserRole ru ON u.id = ru.user.id WHERE u.email = ?1")
	Optional<Object[]> findUserByEmailForLogin(String email);

	@Query("SELECT ru FROM User u JOIN UserRole ru ON u.id = ru.user.id Join Role r ON ru.role.id = r.id WHERE u.username <> ?1 AND u.username <> 'superadmin'")
	List<Object[]> findUserAndRole(String username);

	@Query("SELECT ru FROM User u JOIN UserRole ru ON u.id = ru.user.id Join Role r ON ru.role.id = r.id WHERE u.username <> ?1 AND u.username <> 'superadmin' AND r.name <> 'admin'")
	List<Object[]> findUserAndRoleWithoutAdmin(String username);

	public User findById(int id);

	Optional<User> findUserById(int id);

}
