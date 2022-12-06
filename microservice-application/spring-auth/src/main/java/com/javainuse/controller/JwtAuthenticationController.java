package com.javainuse.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.javainuse.service.JwtUserDetailsService;
import com.javainuse.service.MailingService;

import net.bytebuddy.utility.RandomString;
import net.minidev.json.JSONObject;

import com.javainuse.config.JwtTokenUtil;
import com.javainuse.config.WebSecurityConfig;
import com.javainuse.entities.Role;
import com.javainuse.entities.User;
import com.javainuse.entities.UserRole;
import com.javainuse.model.JwtRequest;
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
	private RegisterNode registerNode;

	@Autowired
	private MailingService mailingService;

	@RequestMapping(value = "/authenticate", method = RequestMethod.POST)
	public ResponseEntity<JSONObject> createAuthenticationToken(@RequestBody JwtRequest authenticationRequest) {
		JSONObject item = new JSONObject();
		try {
			authenticate(authenticationRequest.getUsername(), authenticationRequest.getPassword());
			final UserDetails userDetails = userDetailsService
					.loadUserByUsername(authenticationRequest.getUsername());
			final String token = jwtTokenUtil.generateToken(userDetails);
			item.put("token", token);
			item.put("user", userRepository.findUserByEmailForLogin(authenticationRequest.getUsername()).get());
			return new ResponseEntity<JSONObject>(item, HttpStatus.OK);
		} catch (Exception e) {
			item.put("error", e.getMessage());
			return new ResponseEntity<JSONObject>(item, HttpStatus.BAD_REQUEST);
		}
	}

	private void authenticate(String username, String password) throws Exception {
		try {
			if (!userRepository.findUserByEmail(username).isPresent()) {
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

	public ResponseEntity<JSONObject> saveUser(@RequestBody JSONObject user) {

		User appUser = new User();
		user.get("email");
		if (userRepository.findByUsername(user.get("email").toString()).isPresent()) {
			JSONObject item = new JSONObject();
			item.put("message", "email already exists");
			item.put("status", HttpStatus.BAD_REQUEST.value());
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
		}
		if (userRepository.findByUsername(user.get("username").toString()).isPresent()) {
			JSONObject item = new JSONObject();
			item.put("message", "username already exists");
			item.put("status", HttpStatus.BAD_REQUEST.value());
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
		}
		if (!user.get("password").toString().equals(user.get("confirmPassword").toString())) {
			JSONObject item = new JSONObject();
			item.put("message", "Please confirm Password");
			item.put("status", HttpStatus.BAD_REQUEST.value());
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
		}

		appUser.setUsername(user.get("username").toString());
		appUser.setPassword(WebSecurityConfig.passwordEncoder().encode(user.get("password").toString()));
		appUser.setName(user.get("name").toString());
		appUser.setEmail(user.get("email").toString());
		appUser.setVerificationCode(RandomString.make(8));
		appUser.setEnabled(false);
		appUser.getRoles().add(roleRepository.findRoleWithName(user.get("role").toString()));
		Role newRole = roleRepository.findRoleWithName(user.get("role").toString());
		appUser.getRoles().add(newRole);
		User newUser = userRepository.save(appUser);
		Optional<UserRole> userRole = userRoleRepository.findFirstByUserId(newUser.getId());
		if (user.get("role").toString().equals("Super Admin")) {
			userRole.get().setStatus(1);
		}
		if (user.get("role").toString().equals("Admin")) {
			userRole.get().setStatus(1);
		}
		if (user.get("role").toString().equals("Scooter Owner")) {
			userRole.get().setStatus(0);
		}
		if (user.get("role").toString().equals("SAV Manager")) {
			userRole.get().setStatus(0);
		}
		if (user.get("role").toString().equals("SAV Techinician")) {
			userRole.get().setStatus(0);
		}
		userRoleRepository.save(userRole.get());
		JSONObject newUserNode = new JSONObject();
		newUserNode.put("name", user.get("name").toString());
		newUserNode.put("username", user.get("email").toString());
		newUserNode.put("roles", user.get("role").toString());
		newUserNode.put("password", user.get("password").toString());
		newUserNode.put("status", userRole.get().getStatus());
		User userNode = registerNode.register(newUserNode);

		try {
			mailingService.sendVerificationEmail(newUser);
		} catch (Exception e) {
			JSONObject item = new JSONObject();
			item.put("message", e.getMessage());
			item.put("status", HttpStatus.BAD_REQUEST.value());
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
		}

		JSONObject item = new JSONObject();
		item.put("message", "Account");
		item.put("user", userRepository.findByUsername(newUser.getUsername()).get());

		return ResponseEntity.status(HttpStatus.CREATED).body(item);

	}

	@RequestMapping(value = "/roles", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getRoles() {
		JSONObject item = new JSONObject();
		item.put("roles", roleRepository.findAll());
		return ResponseEntity.status(HttpStatus.OK).body(item);
	}

	@RequestMapping(value = "/accept/{idUser}/{idRole}", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> accept(@PathVariable("idUser") int id, @PathVariable("idRole") Long idRole) {
		JSONObject item = new JSONObject();
		Optional<UserRole> userRole = userRoleRepository.findByUserIdAndRoleId(id, idRole);
		if (userRole.isPresent()) {
			userRole.get().setStatus(1);
			userRoleRepository.save(userRole.get());
			item.put("message", "User accepted");
			return ResponseEntity.status(HttpStatus.OK).body(item);
		}
		item.put("message", "User not found");
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
	}

	@RequestMapping(value = "/reject/{idUser}/{idRole}", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> reject(@PathVariable("idUser") int id, @PathVariable("idRole") Long idRole) {
		JSONObject item = new JSONObject();
		Optional<UserRole> userRole = userRoleRepository.findByUserIdAndRoleId(id, idRole);
		if (userRole.isPresent()) {
			userRole.get().setStatus(2);
			userRoleRepository.save(userRole.get());
			item.put("message", "User Rejected");
			return ResponseEntity.status(HttpStatus.OK).body(item);
		}
		item.put("message", "User not found");
		return ResponseEntity.status(HttpStatus.OK).body(item);
	}

	// list of users where status = 0
	@RequestMapping(value = "/pending", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> pending() {
		JSONObject item = new JSONObject();
		List<UserRole> userRoles = userRoleRepository.findAllByStatus(0);
		List<User> users = new ArrayList<User>();
		for (UserRole userRole : userRoles) {
			users.add(userRepository.findById(userRole.getUser().getId()).get());
		}
		item.put("users", users);
		return ResponseEntity.status(HttpStatus.OK).body(item);
	}

	// return pivot table of users and their roles
	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> users() {
		JSONObject item = new JSONObject();
		List<Object[]> userRoles = userRepository.findUserAndRole();
		item.put("users", userRoles);
		return ResponseEntity.status(HttpStatus.OK).body(item);
	}

}