package com.javainuse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.javainuse.entities.User;
import com.javainuse.repository.UserRepository;

@SpringBootApplication
public class SpringAuthApplication implements CommandLineRunner {

	@Autowired
	UserRepository userRepository;

	public static void main(String[] args) {
		SpringApplication.run(SpringAuthApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		userRepository
				.save(new User("sabrine-kamkoum", "$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q"));
		userRepository
				.save(new User("smurfs-team", "$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q"));
	}

}
