package com.javainuse.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.javainuse.repository.UserRepository;

@RestController
@CrossOrigin
public class UniqueController {

	@Autowired
	UserRepository userRepository;

	@GetMapping("/checkEmail/{email}")
	public ResponseEntity checkEmail(@PathVariable String email) {
		return new ResponseEntity<>(userRepository.findByEmail(email) == null, HttpStatus.OK);
	}

}
