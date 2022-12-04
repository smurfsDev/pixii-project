package com.javainuse.service;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.javainuse.entities.User;

@Service
public class MailingService {

	@Autowired
	private JavaMailSender mailSender;

	public void sendForgotPassEmail(String recipientEmail, String token)
			throws MessagingException, UnsupportedEncodingException {
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);
		String fromAddress = "noreplaypiiximotors@gmail.com";
		String senderName = "Pixii motors";
		helper.setTo(recipientEmail);
		String subject = "Here's the token to reset your password";
		String content = "<p>Hello,</p>"
				+ "<p>You have requested to reset your password.</p>"
				+ "<p>Use the token below to change your password:</p>"
				+ "<h2> " + token + "</h2>"
				+ "<br>"
				+ "<p>Ignore this email if you do remember your password, "
				+ "or you have not made the request.</p><br>"
				+ "Pixii motors.";
		helper.setSubject(subject);
		helper.setFrom(fromAddress, senderName);
		helper.setSubject(subject);
		helper.setText(content, true);
		mailSender.send(message);
	}

	public void sendVerificationEmail(User user)
			throws MessagingException, UnsupportedEncodingException {
		String toAddress = user.getEmail();
		String fromAddress = "noreplaypiiximotors@gmail.com";
		String senderName = "Pixii motors";
		String subject = "Please verify your registration";
		String content = "Dear [[name]],<br>"
				+ "Use the token below to verify your registration:<br>"
				+ "<h3>[[OTP]]</h3>"
				+ "Thank you,<br>"
				+ "Pixii motors.";

		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);

		helper.setFrom(fromAddress, senderName);
		helper.setTo(toAddress);
		helper.setSubject(subject);

		content = content.replace("[[name]]", user.getName());
		content = content.replace("[[OTP]]", user.getVerificationCode());

		helper.setText(content, true);

		mailSender.send(message);
	}

}
