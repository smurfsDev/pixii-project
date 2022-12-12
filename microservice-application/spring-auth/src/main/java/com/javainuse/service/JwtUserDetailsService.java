package com.javainuse.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.javainuse.entities.Role;
import com.javainuse.entities.User;
import com.javainuse.model.MyUserDetail;
import com.javainuse.repository.UserRepository;
import com.javainuse.repository.UserRoleRepository;

@Service
public class JwtUserDetailsService implements UserDetailsService {

	@Autowired
	UserRepository userRepository;
	@Autowired
	private UserRoleRepository userRoleRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("username: " + username);
		User user = userRepository.findUserByEmail(username)
				.orElseThrow(() -> new UsernameNotFoundException("User not found"));
		System.out.println("user details : " + user.getUsername() + " " + user.getPassword() + " id : " + user.getId());
		Collection<GrantedAuthority> authorities = new ArrayList<>();

		Set<Role> roles = user.getRoles();
		for (Role role : roles) {
			Integer status = userRoleRepository.findStatusByUserIdAndRoleId(user.getId(),
					role.getId());
			if (status == 1) {
				authorities.add(new SimpleGrantedAuthority(role.getName()));
			}
		}

		return new MyUserDetail(user, authorities);
	}

	public UserDetails loadUserByUsernameReel(String username) throws UsernameNotFoundException {
		System.out.println("username: " + username);
		User user = userRepository.findByUsername(username)
				.orElseThrow(() -> new UsernameNotFoundException("User not found"));
		System.out.println("user details : " + user.getUsername() + " " + user.getPassword() + " id : " + user.getId());
		Collection<GrantedAuthority> authorities = new ArrayList<>();

		Set<Role> roles = user.getRoles();
		for (Role role : roles) {
			Integer status = userRoleRepository.findStatusByUserIdAndRoleId(user.getId(),
					role.getId());
			if (status == 1) {
				authorities.add(new SimpleGrantedAuthority(role.getName()));
			}
		}
		return new MyUserDetail(user, authorities);

	}
}