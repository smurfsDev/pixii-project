package com.javainuse.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.javainuse.model.MyUserDetail;
import com.javainuse.repository.UserRepository;

@Service
public class JwtUserDetailsService implements UserDetailsService {

    @Autowired
    UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("username: " + username);
        com.javainuse.entities.User user = userRepository.findUserWithName(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
        System.out.println("user details : " + user.getUsername() + " " + user.getPassword() + " id : " + user.getId());

        return new MyUserDetail(user);
        // if ("javainuse".equals(username)) {
        // return new User("javainuse",
        // "$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6",
        // new ArrayList<>());
        // } else {
        // throw new UsernameNotFoundException("User not found with username: " +
        // username);
        // }
    }
}