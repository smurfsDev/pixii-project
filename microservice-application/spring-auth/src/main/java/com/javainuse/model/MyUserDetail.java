package com.javainuse.model;

import java.util.Collection;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.swing.GroupLayout.Group;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.javainuse.entities.Role;
import com.javainuse.entities.User;
import com.javainuse.entities.UserRole;
import com.javainuse.repository.UserRoleRepository;

public class MyUserDetail implements UserDetails {

	private User user;
	private Collection<GrantedAuthority> authorities;

	public MyUserDetail(User user) {
		this.user = user;
	}

	public MyUserDetail(User user2, Collection<GrantedAuthority> authorities2) {
		this.user = user2;
		this.authorities = authorities2;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return user.getPassword();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return user.getUsername();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return user.isEnabled();
	}

}
