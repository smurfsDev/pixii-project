package com.javainuse.controller;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.javainuse.config.WebSecurityConfig;
import com.javainuse.service.UserService;

import net.bytebuddy.utility.RandomString;
import net.minidev.json.JSONObject;

@RestController
@CrossOrigin
public class ForgetPasswordController {
    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private UserService userService;

    @PostMapping("/forgot_password")
    public ResponseEntity<JSONObject> processForgotPassword(@RequestBody JSONObject user, HttpServletRequest request) {
        String email = user.getAsString("email");
        String token = RandomString.make(8);
        JSONObject json = new JSONObject();
        ResponseEntity<JSONObject> response = null;
        try {
            userService.createPasswordResetTokenForUser(email, token);
            sendEmail(email, token);
            json.put("message", "We have sent a reset password token to your email. Please check.");
            response = new ResponseEntity<JSONObject>(json, HttpStatus.OK);
            return response;
        } catch (UsernameNotFoundException ex) {
            json.put("message", ex.getMessage());
            response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
            return response;
        } catch (UnsupportedEncodingException | MessagingException e) {
            json.put("message", "Error while sending email");
            response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
            return response;
        }
    }

    public void sendEmail(String recipientEmail, String token)
            throws MessagingException, UnsupportedEncodingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);
        helper.setFrom("test@example.com", "");
        helper.setTo(recipientEmail);
        String subject = "Here's the token to reset your password";
        String content = "<p>Hello,</p>"
                + "<p>You have requested to reset your password.</p>"
                + "<p>Click the token below to change your password:</p>"
                + "<h2> " + token + "</h2>"
                + "<br>"
                + "<p>Ignore this email if you do remember your password, "
                + "or you have not made the request.</p>";
        helper.setSubject(subject);
        helper.setText(content, true);
        mailSender.send(message);
    }

    @PostMapping("/reset_password")
    public ResponseEntity<JSONObject> processResetPassword(
            @RequestBody JSONObject rqs) {
        if (rqs.getAsString("email") == null || rqs.getAsString("token") == null || rqs.getAsString("password") == null) {
            JSONObject json = new JSONObject();
            json.put("message", "Email or token or password is null");
            return new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
        } else {
            String token = rqs.getAsString("token");
            String password = rqs.getAsString("password");
            String email = rqs.getAsString("email");
            JSONObject json = new JSONObject();
            ResponseEntity<JSONObject> response = null;
            try {
                userService.changeUserPassword(email,token, WebSecurityConfig.passwordEncoder().encode(password));
                json.put("message", "You have successfully changed your password.");
                response = new ResponseEntity<JSONObject>(json, HttpStatus.OK);
                return response;
            } catch (UsernameNotFoundException ex) {
                json.put("message", ex.getMessage());
                response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
                return response;
            } catch (Exception e) {
                json.put("message", e.getMessage());
                response = new ResponseEntity<JSONObject>(json, HttpStatus.BAD_REQUEST);
                return response;
            }
        }
    }
}