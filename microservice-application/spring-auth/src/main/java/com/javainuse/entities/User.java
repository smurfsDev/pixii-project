package com.javainuse.entities;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;

// import java.security.Timestamp;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;

// import org.hibernate.annotations.CreationTimestamp;
// import org.hibernate.annotations.UpdateTimestamp;

@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    // private @Id @GeneratedValue Integer id;
    private String username;

    private String name;
    private String password;
    // private String confirmPassword;

    @ManyToMany(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @JoinTable(name = "users_roles", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))

    private Set<Role> roles = new HashSet<>();

    public User(String username, String password, String name, Set<Role> roles) {
        this.username = username;
        this.name = name;
        // this.email = email;
        this.password = password;
        // this.confirmPassword = confirmPassword;
        this.roles = roles;
    }

    public User(String username, String name, String password) {

        this.username = username;
        this.name = name;
        // this.email = email;
        this.password = password;
        // this.confirmPassword = confirmPassword;
    }

    public User() {
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // public void setConfirmPassword(String confirmPassword) {
    // this.confirmPassword = confirmPassword;
    // }

    public Integer getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }

    // public String getConfirmPassword() {
    // return confirmPassword;
    // }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

}
