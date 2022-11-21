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
import com.javainuse.service.MailingService;
import com.javainuse.service.UserService;

import net.bytebuddy.utility.RandomString;
import net.minidev.json.JSONObject;

@RestController
@CrossOrigin
public class ForgetPasswordController {
	@Autowired
	private MailingService mailingService;

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
			mailingService.sendForgotPassEmail(email, token);
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

	@PostMapping("/reset_password")
	public ResponseEntity<JSONObject> processResetPassword(
			@RequestBody JSONObject rqs) {
		if (rqs.getAsString("email") == null || rqs.getAsString("token") == null
				|| rqs.getAsString("password") == null) {
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
				userService.changeUserPassword(email, token, WebSecurityConfig.passwordEncoder().encode(password));
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