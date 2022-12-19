package com.javainuse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import com.javainuse.entities.Role;
import com.javainuse.entities.User;
import com.javainuse.entities.UserRole;
import com.javainuse.repository.RoleRepository;
import com.javainuse.repository.UserRepository;
import com.javainuse.repository.UserRoleRepository;

@SpringBootApplication
@EnableFeignClients
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

		User user1 = new User("superadmin", "superadmin@email.com", "Super Admin",
				"$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS");

		User user2 = userRepository
				.save(new User("admin", "admin@email.com", "Admin",
						"$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS"));
		User user6 = userRepository
				.save(new User("admin2", "admin2@email.com", "Admin2",
						"$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS"));

		User user3 = userRepository
				.save(new User("savmanager", "savmanager@email.com", "SAV Manager",
						"$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS"));
		User user4 = userRepository
				.save(new User("savtechnician", "savtechnician@email.com", "SAV Technician",
						"$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS"));
		User user5 = userRepository
				.save(new User("scooterowner", "scooterowner@email.com", "Scooter Owner",
						"$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS"));// password = Password123

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
		user6.getRoles().add(adminRole);
		user6.getRoles().add(savManagerRole);

		User super_admin = userRepository.save(user1);
		User admin = userRepository.save(user2);
		User savManger = userRepository.save(user3);
		User savTechnician = userRepository.save(user4);
		User scooterOwner = userRepository.save(user5);
		User admin2 = userRepository.save(user6);

		admin.setEnabled(true);
		admin2.setEnabled(true);
		super_admin.setEnabled(true);
		savManger.setEnabled(true);
		savTechnician.setEnabled(true);
		scooterOwner.setEnabled(true);

		userRepository.save(admin);
		userRepository.save(admin2);
		userRepository.save(super_admin);
		userRepository.save(savManger);
		userRepository.save(savTechnician);
		userRepository.save(scooterOwner);

		UserRole ur1 = userRoleRepository.findFirstByUserId(super_admin.getId()).get();
		ur1.setStatus(1);

		userRoleRepository.save(ur1);

		UserRole ur2 = userRoleRepository.findFirstByUserId(admin.getId()).get();
		ur2.setStatus(1);

		userRoleRepository.save(ur2);

		UserRole ur3 = userRoleRepository.findFirstByUserId(savManger.getId()).get();
		ur3.setStatus(1);

		userRoleRepository.save(ur3);

		UserRole ur4 = userRoleRepository.findFirstByUserId(savTechnician.getId()).get();
		ur1.setStatus(1);

		userRoleRepository.save(ur4);

		UserRole ur5 = userRoleRepository.findFirstByUserId(scooterOwner.getId()).get();
		ur5.setStatus(1);
		ur5.setBike_id("12345678");

		userRoleRepository.save(ur5);

		UserRole ur6 = userRoleRepository.findFirstByUserId(admin2.getId()).get();
		ur6.setStatus(0);

		userRoleRepository.save(ur6);

		// UserRole ur1 = userRoleRepository.findFirstByUser(super_admin.getId()).get();
		// ur1.setRole(superAdminRole);
		// ur1.setStatus(1);
		// userRoleRepository.save(ur1);

		// UserRole ur2 = userRoleRepository.findFirstByUser(super_admin.getId()).get();
		// ur2.setRole(superAdminRole);
		// ur2.setStatus(1);
		// userRoleRepository.save(ur2);

		// UserRole ur3 = userRoleRepository.findFirstByUser(super_admin.getId()).get();
		// ur3.setRole(superAdminRole);
		// ur3.setStatus(1);
		// userRoleRepository.save(ur3);

		// UserRole ur4 = userRoleRepository.findFirstByUser(super_admin.getId()).get();
		// ur4.setRole(superAdminRole);
		// ur4.setStatus(1);
		// userRoleRepository.save(ur4);

		// UserRole ur5 = userRoleRepository.findFirstByUser(super_admin.getId()).get();
		// ur5.setRole(superAdminRole);
		// ur5.setStatus(1);
		// userRoleRepository.save(ur5);
		// UserRole ur2 = userRoleRepository.findFirstByUser(admin.getId()).get();
		// ur2.setStatus(1);

		// UserRole ur3 = userRoleRepository.findFirstByUser(savManger.getId()).get();
		// ur3.setStatus(1);

		// UserRole ur4 =
		// userRoleRepository.findFirstByUser(savTechnician.getId()).get();
		// ur4.setStatus(1);

		// UserRole ur5 =
		// userRoleRepository.findFirstByUser(scooterOwner.getId()).get();
		// ur5.setStatus(1);

		// userRoleRepository.save(ur1);
		// userRoleRepository.save(ur2);
		// userRoleRepository.save(ur3);
		// userRoleRepository.save(ur4);
		// userRoleRepository.save(ur5);

	}

}
