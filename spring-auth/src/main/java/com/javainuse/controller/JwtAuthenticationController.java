package com.javainuse.controller;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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

import net.bytebuddy.utility.RandomString;
import net.minidev.json.JSONObject;

import com.javainuse.config.JwtTokenUtil;
import com.javainuse.config.WebSecurityConfig;
import com.javainuse.entities.Role;
import com.javainuse.entities.User;

import com.javainuse.model.JwtRequest;
import com.javainuse.model.JwtResponse;
import com.javainuse.repository.RoleRepository;
import com.javainuse.repository.UserRepository;
import com.javainuse.repository.UserRoleRepository;

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

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    UserRoleRepository userRoleRepository;

    @Autowired
    private JavaMailSender mailSender;

    @RequestMapping(value = "/authenticate", method = RequestMethod.POST)

    public JSONObject createAuthenticationToken(@RequestBody JwtRequest authenticationRequest) {
        JSONObject item = new JSONObject();
        try {
            authenticate(authenticationRequest.getUsername(), authenticationRequest.getPassword());
            final UserDetails userDetails = userDetailsService
                    .loadUserByUsername(authenticationRequest.getUsername());
            final String token = jwtTokenUtil.generateToken(userDetails);
            item.put("token", token);
            item.put("user", userRepository.findUserWithName(authenticationRequest.getUsername()).get());
            return new ResponseEntity<JSONObject>(item, HttpStatus.OK).getBody();
        } catch (Exception e) {
            item.put("error", e.getMessage());
            return new ResponseEntity<JSONObject>(item, HttpStatus.BAD_REQUEST).getBody();
        }
    }

    private void authenticate(String username, String password) throws Exception {
        try {
            if (!userRepository.findUserWithName(username).isPresent()) {
                throw new Exception("USER_NOT_FOUND");
            }
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (DisabledException e) {
            throw new Exception("USER_DISABLED", e);
        } catch (BadCredentialsException e) {
            throw new Exception("INVALID_CREDENTIALS", e);
        }
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)

    public ResponseEntity<JSONObject> saveUser(@RequestBody JSONObject user, HttpServletRequest request)
            {

        User appUser = new User();
        user.get("email");
        if (userRepository.findUserWithName(user.get("email").toString()).isPresent() == true) {
            JSONObject item = new JSONObject();
            item.put("message", "User already exists");
            item.put("status", HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
        }
        if (!user.get("password").toString().equals(user.get("confirmPassword").toString())) {
            JSONObject item = new JSONObject();
            item.put("message", "Please confirm Password");
            item.put("status", HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
        }

        appUser.setUsername(user.get("email").toString());
        appUser.setName(user.get("name").toString());
        // appUser.setEmail(user.get("email").toString());
        // if (roleRepository.getById(idRole) != null) {
        appUser.getRoles().add(roleRepository.findRoleWithName(user.get("role").toString()));
        appUser.setPassword(WebSecurityConfig.passwordEncoder().encode(user.get("password").toString()));
        // appUser.setConfirmPassword(WebSecurityConfig.passwordEncoder().encode(user.get("confirmPassword").toString()));
        Role newRole = roleRepository.findRoleWithName(user.get("role").toString());
        appUser.getRoles().add(newRole);

        String randomCode = RandomString.make(8);
        appUser.setVerificationCode(randomCode);
        appUser.setEnabled(false);

        User newUser = userRepository.save(appUser);
        try{
            sendVerificationEmail(newUser, request.getRequestURL().toString().replace(request.getServletPath(), ""));
        }catch(Exception e){
            JSONObject item = new JSONObject();
            item.put("message", "Error sending email");
            item.put("status", HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
        }

        JSONObject item = new JSONObject();
        item.put("message", "Account");
        item.put("username", newUser.getUsername());
        // item.put("email", newUser.getEmail());
        item.put("role", newUser.getRoles());
        return ResponseEntity.status(HttpStatus.CREATED).body(item);

    }

    private void sendVerificationEmail(User user, String siteURL)
            throws MessagingException, UnsupportedEncodingException {
        String toAddress = user.getEmail();
        String fromAddress = "noreplaypiiximotors@gmail.com";
        String senderName = "Your company name";
        String subject = "Please verify your registration";
        String content = "Dear [[name]],<br>"
                + "Please click the link below to verify your registration:<br>"
                + "<h3>[[OTP]]</h3>"
                + "Thank you,<br>"
                + "Your company name.";

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);

        helper.setFrom(fromAddress, senderName);
        helper.setTo(toAddress);
        helper.setSubject(subject);

        content = content.replace("[[name]]", user.getUsername());
        content = content.replace("[[OTP]]", user.getVerificationCode());

        helper.setText(content, true);

        mailSender.send(message);

    }

    @RequestMapping(value = "/roles", method = RequestMethod.GET)
    public ResponseEntity<JSONObject> getRoles() {
        JSONObject item = new JSONObject();
        item.put("roles", roleRepository.findAll());
        return ResponseEntity.status(HttpStatus.OK).body(item);
    }
         @RequestMapping(value = "/register", method = RequestMethod.POST)

 public ResponseEntity<JSONObject> saveUser(@RequestBody User newUser,
     @RequestBody Long idRole) {

     User appUser = new User();
     if (userRepository.findUserWithName(newUser.getUsername()).isPresent() ==
     true) {
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
     if (roleRepository.getById(idRole) != null) {

     appUser.getRoles().add(roleRepository.getById(idRole));
    }

     appUser.setPassword(WebSecurityConfig.passwordEncoder().encode(newUser.getPassword()));
     User user = userRepository.save(appUser);

     UserRole userRole = new UserRole();

     userRole.setUser(user);
     userRoleRepository.save(userRole);
     JSONObject item = new JSONObject();
     item.put("message", "Account");
     item.put("username", appUser.getUsername());
     item.put("email", appUser.getEmail());
     item.put("role", appUser.getRoles());

     return ResponseEntity.status(HttpStatus.CREATED).body(item);

     }
}
   
