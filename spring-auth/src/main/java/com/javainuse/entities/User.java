package com.javainuse.entities;

import java.security.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    // private @Id @GeneratedValue Integer id;
    private String username;
    private String password;

    // @CreationTimestamp
    // private Timestamp created_at;

    // @UpdateTimestamp
    // private Timestamp updated_at;

    public User() {
    }

    public User(Integer id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
        // this.created_at = created_at;
        // this.updated_at = updated_at;
    }

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public Integer getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    // public Timestamp getCreated_at() {
    // return created_at;
    // }

    // public Timestamp getUpdated_at() {
    // return updated_at;
    // }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // public void setCreated_at(Timestamp created_at) {
    // this.created_at = created_at;
    // }

    // public void setUpdated_at(Timestamp updated_at) {
    // this.updated_at = updated_at;
    // }

}
