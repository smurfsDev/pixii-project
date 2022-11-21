package com.javainuse.service;

import java.util.Calendar;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.javainuse.entities.ResetPassword;
import com.javainuse.entities.User;
import com.javainuse.repository.ResetPasswordRepository;
import com.javainuse.repository.UserRepository;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserRepository userrepository;

	@Autowired
	private ResetPasswordRepository resetPasswordRepository;

	public void createPasswordResetTokenForUser(String email, String token) throws UsernameNotFoundException {
		User user = userrepository.findByEmail(email);
		if (user != null) {
			ResetPassword resetPassword = new ResetPassword(email, token, user);
			resetPasswordRepository.save(resetPassword);
		} else {
			throw new UsernameNotFoundException("User not found");
		}
	}

	public void verify(String email, String verificationCode) throws Exception {

		Optional<User> user = userrepository.findUserByEmail(email);
		if (user.isPresent()) {
			User user1 = user.get();
			if (user1 == null) {
				throw new Exception("User not found");
			} else if (user1.isEnabled()) {
				throw new Exception("User already verified");
			} else {
				if (user1.getVerificationCode().equals(verificationCode)) {
					user1.setVerificationCode(null);
					user1.setEnabled(true);
					userrepository.save(user1);
				} else {
					throw new Exception("Wrong verification code");
				}
			}
		} else {
			throw new Exception("User not found");
		}

	}

	private boolean isTokenExpired(ResetPassword passToken) {
		final Calendar cal = Calendar.getInstance();
		// minus 1 hour
		cal.add(Calendar.HOUR, -1);
		return passToken.getExpiryDate()
				.before(cal.getTime());
	}

	public void changeUserPassword(String email, String token, String password) throws Exception {
		Optional<User> user = userrepository.findUserByEmail(email);
		if (user.isPresent()) {
			User user1 = user.get();
			if (user1 == null) {
				throw new Exception("User not found");
			} else {
				ResetPassword resetPassword = resetPasswordRepository.findByEmail(email);
				if (resetPassword == null) {
					throw new Exception("Token not found");
				} else {
					if (resetPassword.getToken().equals(token)) {
						System.out.println("token matched");
						System.out.println(resetPassword.getExpiryDate().getTime());
						System.out.println(System.currentTimeMillis());
						if (isTokenExpired(resetPassword)) {
							throw new Exception("Token expired");
						}
						user1.setPassword(password);
						userrepository.save(user1);
						resetPasswordRepository.delete(resetPassword);
					} else {
						throw new Exception("Wrong token");
					}
				}
			}
		} else {
			throw new Exception("User not found");
		}
	}

}
