package com.javainuse.controller;

import org.springframework.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.javainuse.repository.UserRepository;
import com.javainuse.service.MailingService;
import com.javainuse.service.UserService;

import net.minidev.json.JSONObject;

@RestController
@CrossOrigin
public class VerificationController {
	@Autowired
	private UserRepository userRepo;
	@Autowired
	private UserService service;
	@Autowired
	private MailingService mailingService;

	@PostMapping("/verify")
	public ResponseEntity<JSONObject> verifyUser(@RequestBody JSONObject req) {
		JSONObject res = new JSONObject();
		ResponseEntity<JSONObject> response = null;
		if (req.containsKey("code") && req.containsKey("email")) {
			try {
				service.verify(req.getAsString("email"), req.getAsString("code"));
				res.put("message", "User verified successfully");
				response = ResponseEntity.ok(res);
			} catch (Exception e) {
				res.put("message", e.getMessage());
				response = ResponseEntity.badRequest().body(res);
			}
		} else {
			res.put("message", "Invalid request, email or code is missing");
			response = ResponseEntity.status(400).body(res);
		}

		return response;
	}

	@PostMapping("/resend")
	public ResponseEntity<JSONObject> resendCode(@RequestBody JSONObject req) {
		JSONObject res = new JSONObject();
		ResponseEntity<JSONObject> response = null;
		if (req.containsKey("email")) {
			if (userRepo.findUserByEmail(req.getAsString("email")).isPresent()) {
				try {
					service.resendCode(req.getAsString("email"));
					res.put("message", "Code sent successfully");
					response = ResponseEntity.ok(res);
					try {
						mailingService.sendVerificationEmail(userRepo.findUserByEmail(req.getAsString("email")).get());
					} catch (Exception e) {
						JSONObject item = new JSONObject();
						item.put("message", e.getMessage());
						item.put("status", HttpStatus.BAD_REQUEST.value());
						e.printStackTrace();
						return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
					}

				} catch (Exception e) {
					res.put("message", e.getMessage());
					response = ResponseEntity.badRequest().body(res);
				}
			} else {
				res.put("message", "User not found");
				response = ResponseEntity.badRequest().body(res);
			}

		} else {
			res.put("message", "Invalid request, email is missing");
			response = ResponseEntity.status(400).body(res);
		}

		return response;
	}
}
