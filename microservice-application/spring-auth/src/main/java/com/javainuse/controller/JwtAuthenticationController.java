package com.javainuse.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
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

	public User getUser(HttpServletRequest request) {
		Principal principal = request.getUserPrincipal();
		User user = userRepository.findByUsername(principal.getName()).get();
		return user;
	}

	@RequestMapping(value = "/authenticate", method = RequestMethod.POST)
	public ResponseEntity<JSONObject> createAuthenticationToken(@RequestBody JwtRequest authenticationRequest) {
		JSONObject item = new JSONObject();
		try {
			authenticate(authenticationRequest.getUsername(), authenticationRequest.getPassword());
			final UserDetails userDetails = userDetailsService
					.loadUserByUsername(authenticationRequest.getUsername());
			final String token = jwtTokenUtil.generateToken(userDetails);
			item.put("token", token);
			User user = userRepository.findUserByEmail(authenticationRequest.getUsername()).get();
			Object userResp = new Object() {
				public Integer id = user.getId();
				public String username = user.getUsername();
				public String email = user.getEmail();
				public String name = user.getName();
				public String password = user.getPassword();
				public Object roles = user.getRoles().stream().map(role -> new Object() {
					public Long id = role.getId();
					public String name = role.getName();
					UserRole userRole = userRoleRepository.findByUserIdAndRoleId(user.getId(), role.getId()).get();
					public Integer status = userRole.getStatus();
				}).collect(Collectors.toList());
			};

			item.put("user", userResp);
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
		if (userRepository.findUserByEmail(user.get("email").toString()).isPresent()) {
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
			userRole.get().setStatus(0);
		}
		if (user.get("role").toString().equals("Scooter Owner")) {
			userRole.get().setStatus(0);
			// user Authority is not set

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
		newUserNode.put("email", user.get("email").toString());
		newUserNode.put("username", user.get("username").toString());
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

	// @RequestMapping(value = "/roles", method = RequestMethod.GET)
	// public ResponseEntity<JSONObject> getRoles() {
	// JSONObject item = new JSONObject();
	// item.put("roles", roleRepository.findAll());
	// return ResponseEntity.status(HttpStatus.OK).body(item);
	// }
	// retern roles without super admin
	@RequestMapping(value = "/roles", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getRoles() {
		JSONObject item = new JSONObject();
		item.put("roles", roleRepository.findAll().stream().filter(role -> !role.getName().equals("Super Admin"))
				.collect(Collectors.toList()));
		return ResponseEntity.status(HttpStatus.OK).body(item);
	}

	@RequestMapping(value = "/accept/{idUser}/{idRole}", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> accept(@PathVariable("idUser") int id, @PathVariable("idRole") Long idRole) {
		JSONObject item = new JSONObject();
		boolean isSuperAdmin = false;
		boolean isAdmin = false;

		Optional<UserRole> userRoleOptional = userRoleRepository.findByUserIdAndRoleId(id, idRole);
		if (!userRoleOptional.isPresent()) {
			item.put("message", "user role not found");
			item.put("status", HttpStatus.BAD_REQUEST.value());
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
		}
		UserRole userRole = userRoleOptional.get();
		String userAcceptedRole = userRole.getRole().getName();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = userRepository.findByUsername(auth.getName()).get();
		Set<Role> roles = user.getRoles();
		for (Role role : roles) {
			if (role.getName().equals("Super Admin")) {
				isSuperAdmin = true;
			} else if (role.getName().equals("Admin")) {
				isAdmin = true;
			}
		}

		if (isSuperAdmin == true && userAcceptedRole.equals("Admin") && isAdmin == false) {
			acceptUser(userRole);
			item.put("message", "admin accepted");
			return ResponseEntity.status(HttpStatus.OK).body(item);
		} else if (userAcceptedRole.equals("SAV Manager") && (isSuperAdmin || isAdmin)) {
			acceptUser(userRole);
			item.put("message", "SAV Manager accepted");
			return ResponseEntity.status(HttpStatus.OK).body(item);
		} else if (userAcceptedRole.equals("SAV Technician")
				&& (isSuperAdmin || isAdmin)) {
			acceptUser(userRole);
			item.put("message", "SAV Technician accepted");
			return ResponseEntity.status(HttpStatus.OK).body(item);
		}
		item.put("message", "You are not allowed to accept this role");
		registerNode.accept(user.getUsername(), userAcceptedRole);
		return ResponseEntity.status(HttpStatus.FORBIDDEN).body(item);
	}

	@RequestMapping(value = "/reject/{idUser}/{idRole}", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> reject(@PathVariable("idUser") int id, @PathVariable("idRole") Long idRole) {
		JSONObject item = new JSONObject();
		boolean isSuperAdmin = false;
		boolean isAdmin = false;
		Optional<UserRole> userRoleOptional = userRoleRepository.findByUserIdAndRoleId(id, idRole);
		if (!userRoleOptional.isPresent()) {
			item.put("message", "user role not found");
			item.put("status", HttpStatus.BAD_REQUEST.value());
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(item);
		}
		UserRole userRole = userRoleOptional.get();
		String userDeclinedRole = userRole.getRole().getName();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = userRepository.findByUsername(auth.getName()).get();
		Set<Role> roles = user.getRoles();
		for (Role role : roles) {
			if (role.getName().equals("Super Admin")) {
				isSuperAdmin = true;
			} else if (role.getName().equals("Admin")) {
				isAdmin = true;
			}
		}
		if (isSuperAdmin == true && userDeclinedRole.equals("Admin") && isAdmin == false) {
			rejectUser(userRole);
			item.put("message", "admin rejected");
			return ResponseEntity.status(HttpStatus.OK).body(item);
		} else if (userDeclinedRole.equals("SAV Manager")
				&& (isSuperAdmin || isAdmin)) {
			rejectUser(userRole);
			item.put("message", "SAV Manager rejected");
			return ResponseEntity.status(HttpStatus.OK).body(item);
		} else if (userDeclinedRole.equals("SAV Technician")
				&& (isSuperAdmin || isAdmin)) {
			rejectUser(userRole);
			item.put("message", "SAV Technician rejected");
			return ResponseEntity.status(HttpStatus.OK).body(item);
		}
		item.put("message", "You are not allowed to accept this role");
		return ResponseEntity.status(HttpStatus.FORBIDDEN).body(item);
	}

	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> users(HttpServletRequest request) {
		JSONObject item = new JSONObject();
		User user = getUser(request);
		if (user.getRoles().contains(roleRepository.findRoleWithName("Admin"))) {
			List<Object[]> userRoles = userRepository.findUserAndRoleWithoutAdmin(user.getUsername());
			item.put("users", userRoles);
			return ResponseEntity.status(HttpStatus.OK).body(item);
		} else if (user.getRoles().contains(roleRepository.findRoleWithName("Super Admin"))) {
			List<Object[]> userRoles = userRepository.findUserAndRole(user.getUsername());
			item.put("users", userRoles);
			return ResponseEntity.status(HttpStatus.OK).body(item);
		}

		item.put("message", "You are not authorized to access this page");
		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(item);
	}

	@RequestMapping(value = "/delete/{idUser}/{idRole}", method = RequestMethod.DELETE)
	public ResponseEntity<JSONObject> deleteUser(@PathVariable("idUser") int id, @PathVariable("idRole") Long idRole,
			HttpServletRequest request) {
		JSONObject item = new JSONObject();
		if (getUser(request).getRoles().contains(roleRepository.findRoleWithName("Super Admin"))) {
			Optional<UserRole> userRole = userRoleRepository.findByUserIdAndRoleId(id, idRole);
			Long count = userRoleRepository.countByUserId(id);
			if (userRole.isPresent() && count > 1) {
				userRoleRepository.delete(userRole.get());
				item.put("message", "UserRole deleted");
				return ResponseEntity.status(HttpStatus.OK).body(item);
			} else if (userRole.isPresent() && count == 1) {
				userRoleRepository.delete(userRole.get());
				userRepository.deleteById(id);
				item.put("message", "User deleted");
				return ResponseEntity.status(HttpStatus.OK).body(item);
			}
		}

		item.put("message", "You are not authorized to access this page");
		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(item);
	}

	void acceptUser(UserRole userRole) {
		userRole.setStatus(1);
		userRoleRepository.save(userRole);
	}

	void rejectUser(UserRole userRole) {
		userRole.setStatus(2);
		userRoleRepository.save(userRole);
	}
}