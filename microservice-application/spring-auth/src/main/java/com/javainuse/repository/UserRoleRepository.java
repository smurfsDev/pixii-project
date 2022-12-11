package com.javainuse.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.javainuse.entities.UserRole;

@EnableJpaRepositories
public interface UserRoleRepository extends JpaRepository<UserRole, Integer> {

    Optional<UserRole> findFirstByUserId(int userId);

    List<UserRole> findAllByStatus(int i);

    Long countByUserId(int userId);

    Optional<UserRole> findByUserIdAndRoleId(int userId, Long roleId);

    @Query("SELECT ru.status FROM User u JOIN UserRole ru ON u.id = ru.user.id Join Role r ON ru.role.id = r.id WHERE u.id = ?1 AND r.id = ?2")
    int findStatusByUserIdAndRoleId(int userId, Long roleId);
}
