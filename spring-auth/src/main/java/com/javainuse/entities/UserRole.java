package com.javainuse.entities;

import javax.persistence.EmbeddedId;
// import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.ColumnDefault;

@Entity
@Table(name = "users_roles")
public class UserRole {
    @EmbeddedId
    UserRoleKey id;

    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    User user;

    @ManyToOne
    @MapsId("roleId")
    @JoinColumn(name = "role_id")
    Role role;

    @NotNull

    @ColumnDefault("0")
    private Integer status;

    public UserRole(UserRoleKey id, User user, Role role, @NotNull Integer status) {
        this.id = id;
        this.user = user;
        this.role = role;
        this.status = status;
    }

    public UserRole() {
    }

    public UserRole(User user, Role role, @NotNull Integer status) {
        this.user = user;
        this.role = role;
        this.status = status;
    }

    public UserRoleKey getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public Role getRole() {
        return role;
    }

    public Integer getStatus() {
        return status;
    }

    public void setId(UserRoleKey id) {
        this.id = id;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

}
