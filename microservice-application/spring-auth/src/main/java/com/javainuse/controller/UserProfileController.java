package com.javainuse.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.javainuse.config.WebSecurityConfig;
import com.javainuse.entities.User;
import com.javainuse.repository.UserRepository;
import com.javainuse.service.MailingService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import net.bytebuddy.utility.RandomString;
import net.minidev.json.JSONObject;

@RestController
@CrossOrigin
public class UserProfileController {
    @Autowired
    private UserRepository userrepository;
    @Autowired
    private MailingService mailingService;

    @GetMapping("/getprofile")
    public ResponseEntity<JSONObject> getProfile(HttpServletRequest request) {
        JSONObject json = new JSONObject();
        ResponseEntity<JSONObject> response = null;

        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user1 = userrepository.findByUsername(auth.getName()).get();
            json.put("username", user1.getUsername());
            json.put("name", user1.getName());
            json.put("email", user1.getEmail());
            json.put("created_at", user1.getCreatedTimestamp());
            json.put("image", user1.getImage());
            json.put("scootername", user1.getScootername());
            response = new ResponseEntity<JSONObject>(json, HttpStatus.OK);
            return response;
        } catch (UsernameNotFoundException ex) {
            json.put("message", ex.getMessage());
            response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
            return response;
        }
    }

    @PutMapping("/profilemodify")
    public ResponseEntity<JSONObject> modifyProfile(@RequestBody JSONObject user, HttpServletRequest request) {
        JSONObject json = new JSONObject();
        ResponseEntity<JSONObject> response = null;

        try {
            boolean emailChanged = false;
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user1 = userrepository.findByUsername(auth.getName()).get();
            json.put("username", user1.getUsername());
            json.put("name", user1.getName());
            json.put("email", user1.getEmail());

            if (userrepository.findUserByEmail(user.get("email").toString()).isPresent()
                    && !user1.getEmail().equals(user.get("email").toString())) {
                JSONObject item = new JSONObject();
                item.put("message", "email already exists");
                item.put("status", HttpStatus.BAD_REQUEST.value());
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
            }

            if (user.containsKey("name"))
                user1.setName(user.get("name").toString());
            if (user.containsKey("email") && !user1.getEmail().equals(user.get("email").toString())) {
                user1.setEmail(user.get("email").toString());
                emailChanged = true;
                user1.setVerificationCode(RandomString.make(8));
                user1.setEnabled(false);
            }

            userrepository.save(user1);
            if (emailChanged) {
                try {
                    mailingService.sendVerificationEmail(user1);
                } catch (Exception e) {
                    JSONObject item = new JSONObject();
                    item.put("message", e.getMessage());
                    item.put("status", HttpStatus.BAD_REQUEST.value());
                    e.printStackTrace();
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
                }
            }

            json.put("message", "User profile details");
            response = new ResponseEntity<JSONObject>(json, HttpStatus.OK);

            return response;
        } catch (UsernameNotFoundException ex) {
            json.put("message", ex.getMessage());
            response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
            return response;
        }

    }

    @PutMapping("/changepassword")
    public ResponseEntity<JSONObject> changePassword(@RequestBody JSONObject user, HttpServletRequest request) {
        JSONObject json = new JSONObject();
        ResponseEntity<JSONObject> response = null;
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user1 = userrepository.findByUsername(auth.getName()).get();

            if ((WebSecurityConfig.passwordEncoder().matches(user.getAsString("oldpassword"), user1.getPassword()))
                    && user.containsKey("password")
                    && !user.get("password").toString().equals(user.get("oldpassword").toString())) {
                user1.setPassword(WebSecurityConfig.passwordEncoder().encode(user.get("password").toString()));
                userrepository.save(user1);
                json.put("message", "Password changed successfully");
                response = new ResponseEntity<JSONObject>(json, HttpStatus.OK);
                return response;

            } else if (user.containsKey("password") == (WebSecurityConfig.passwordEncoder()
                    .matches(user.getAsString("oldpassword"), user1.getPassword()))) {
                json.put("message", "New password cannot be same as old password");
                response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
                return response;
            } else {
                json.put("message", "Old password is incorrect");
                response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
                return response;
            }

        } catch (UsernameNotFoundException ex) {
            json.put("message", ex.getMessage());
            response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
            return response;
        }
    }

    @PutMapping("/scootername")
    public ResponseEntity<JSONObject> putScootername(@RequestBody JSONObject scootername, HttpServletRequest request) {
        JSONObject json = new JSONObject();
        ResponseEntity<JSONObject> response = null;
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user1 = userrepository.findByUsername(auth.getName()).get();
            user1.setscootername(scootername.get("scootername").toString());
            userrepository.save(user1);
            json.put("message", "Scooter name added successfully");
            response = new ResponseEntity<JSONObject>(json, HttpStatus.OK);
            return response;
        } catch (UsernameNotFoundException ex) {
            json.put("message", ex.getMessage());
            response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
            return response;
        }
    }

    @GetMapping("/gscootername")
    public ResponseEntity<JSONObject> getScootername(HttpServletRequest request) {
        JSONObject json = new JSONObject();
        ResponseEntity<JSONObject> response = null;
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user1 = userrepository.findByUsername(auth.getName()).get();
            json.put("scootername", user1.getScootername());

            response = new ResponseEntity<JSONObject>(json, HttpStatus.OK);
            return response;
        } catch (UsernameNotFoundException ex) {
            json.put("message", ex.getMessage());
            response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
            return response;
        }
    }

    @PostMapping("/upload")
    public ResponseEntity<JSONObject> uploadFile(@RequestParam("file") MultipartFile file) {
        JSONObject json = new JSONObject();
        ResponseEntity<JSONObject> response = null;
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user1 = userrepository.findByUsername(auth.getName()).get();
            String fileName = UUID.randomUUID() + "-" + file.getOriginalFilename();
            File uploadedFile = new File("C:/Users/MedNourBn/Desktop/9raya/pixii-project/Angular/src/assets/pdp/" + fileName);
            try {
                file.transferTo(uploadedFile);
            } catch (IllegalStateException | IOException e) {

                e.printStackTrace();
            }
            user1.setImage(fileName);
            userrepository.save(user1);
            json.put("message", "File uploaded successfully");
            response = new ResponseEntity<JSONObject>(json, HttpStatus.OK);
            return response;
        } catch (UsernameNotFoundException ex) {
            json.put("message", ex.getMessage());
            response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
            return response;
        }

    }

    @GetMapping("/getimage")
    public ResponseEntity<JSONObject> getImage(HttpServletRequest request) {
        JSONObject json = new JSONObject();
        ResponseEntity<JSONObject> response = null;
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user1 = userrepository.findByUsername(auth.getName()).get();
            json.put("image", user1.getImage());

            response = new ResponseEntity<JSONObject>(json, HttpStatus.OK);
            return response;
        } catch (UsernameNotFoundException ex) {
            json.put("message", ex.getMessage());
            response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
            return response;
        }
    }
}
