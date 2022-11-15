package com.javainuse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.javainuse.service.JwtUserDetailsService;

import net.minidev.json.JSONObject;

import com.javainuse.config.JwtTokenUtil;
import com.javainuse.config.WebSecurityConfig;
import com.javainuse.entities.User;
import com.javainuse.model.JwtRequest;
import com.javainuse.model.JwtResponse;
import com.javainuse.repository.UserRepository;

@RestController
@CrossOrigin
public class JwtAuthenticationController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private JwtUserDetailsService userDetailsService;

    @Autowired
    UserRepository userRepository;

    @RequestMapping(value = "/authenticate", method = RequestMethod.POST)
    public JSONObject createAuthenticationToken(@RequestBody JwtRequest authenticationRequest)
            throws Exception {

        authenticate(authenticationRequest.getUsername(), authenticationRequest.getPassword());

        final UserDetails userDetails = userDetailsService
                .loadUserByUsername(authenticationRequest.getUsername());

        final String token = jwtTokenUtil.generateToken(userDetails);

        HttpHeaders responseHeaders = new HttpHeaders();
        // responseHeaders.setLocation(location);
        responseHeaders.set("MyResponseHeader", "MyValue");
        JwtResponse tkn = new JwtResponse(token);

        ResponseEntity<String> returned_token = new ResponseEntity<String>(tkn.getToken(), responseHeaders,
                HttpStatus.OK);
        JSONObject item = new JSONObject();
        item.put("token", returned_token);
        item.put("username", authenticationRequest.getUsername());
        return item;

    }

    private void authenticate(String username, String password) throws Exception {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (DisabledException e) {
            throw new Exception("USER_DISABLED", e);
        } catch (BadCredentialsException e) {
            throw new Exception("INVALID_CREDENTIALS", e);
        }
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)

    public ResponseEntity<JSONObject> saveUser(@RequestBody User newUser) {

        User appUser = new User();
        if (userRepository.findUserWithName(newUser.getUsername()).isPresent() == true) {
            JSONObject item = new JSONObject();
            item.put("message", "User already exists");
            item.put("status", HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
        }
        if (!newUser.getPassword().equals(newUser.getConfirmPassword())) {
            JSONObject item = new JSONObject();
            item.put("message", "Please confirm Password");
            item.put("status", HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
        }

        appUser.setUsername(newUser.getUsername());
        appUser.setEmail(newUser.getEmail());

        appUser.setPassword(WebSecurityConfig.passwordEncoder().encode(newUser.getPassword()));
        userRepository.save(appUser);
        JSONObject item = new JSONObject();
        item.put("message", "Account");
        item.put("username", appUser.getUsername());
        item.put("email", appUser.getEmail());

        return ResponseEntity.status(HttpStatus.CREATED).body(item);

    }
}