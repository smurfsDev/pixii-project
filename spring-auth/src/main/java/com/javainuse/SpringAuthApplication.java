package com.javainuse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.javainuse.entities.Role;
import com.javainuse.entities.User;
import com.javainuse.entities.UserRole;
import com.javainuse.repository.RoleRepository;
import com.javainuse.repository.UserRepository;
import com.javainuse.repository.UserRoleRepository;

@SpringBootApplication
public class SpringAuthApplication implements CommandLineRunner {

	@Autowired
	UserRepository userRepository;

	@Autowired
	RoleRepository roleRepository;

	@Autowired
	UserRoleRepository userRoleRepository;

	public static void main(String[] args) {
		SpringApplication.run(SpringAuthApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {

		Role role1 = new Role("Super Admin");
		Role role2 = new Role("Admin");
		Role role3 = new Role("SAV Manager");
		Role role4 = new Role("SAV Technician");
		Role role5 = new Role("Scooter Owner");

		User user1 = new User("Super Admin", "superadmin@email.com",
				"$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q",
				"$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q");

		User user2 = userRepository
				.save(new User("Admin", "admin@email.com",
						"$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q",
						"$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q"));

		User user3 = userRepository
				.save(new User("SAV manager", "savmanager@email.com",
						"$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q",
						"$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q"));
		User user4 = userRepository
				.save(new User("SAV Technician", "savtechnician@email.com",
						"$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q",
						"$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q"));
		User user5 = userRepository
				.save(new User("scooter owner", "scooterowner@email.com",
						"$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q",
						"$2y$10$15weT0pr4JZFgw/K1Xg.5uYprLAYNmURKvetpugUSqkZ3RRprBh4q"));

		Role superAdminRole = roleRepository.save(role1);
		Role adminRole = roleRepository.save(role2);
		Role savManagerRole = roleRepository.save(role3);
		Role savTechnicianRole = roleRepository.save(role4);
		Role scooterOwnerRole = roleRepository.save(role5);

		user1.getRoles().add(superAdminRole);
		user2.getRoles().add(adminRole);
		user3.getRoles().add(savManagerRole);
		user4.getRoles().add(savTechnicianRole);
		user5.getRoles().add(scooterOwnerRole);

		User super_admin = userRepository.save(user1);
		User admin = userRepository.save(user2);
		User savManger = userRepository.save(user3);
		User savTechnician = userRepository.save(user4);
		User scooterOwner = userRepository.save(user5);

		UserRole ur1 = userRoleRepository.findFirstByUserId(super_admin.getId()).get();
		ur1.setStatus(1);

		UserRole ur2 = userRoleRepository.findFirstByUserId(admin.getId()).get();
		ur2.setStatus(1);

		UserRole ur3 = userRoleRepository.findFirstByUserId(savManger.getId()).get();
		ur3.setStatus(1);

		UserRole ur4 = userRoleRepository.findFirstByUserId(savTechnician.getId()).get();
		ur4.setStatus(1);

		UserRole ur5 = userRoleRepository.findFirstByUserId(scooterOwner.getId()).get();
		ur5.setStatus(1);

	}

}
