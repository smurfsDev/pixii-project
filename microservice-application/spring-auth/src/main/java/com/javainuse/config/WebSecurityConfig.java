package com.javainuse.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;

	@Autowired
	private UserDetailsService jwtUserDetailsService;

	@Autowired
	private JwtRequestFilter jwtRequestFilter;

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		// configure AuthenticationManager so that it knows from where to load
		// user for matching credentials
		// Use BCryptPasswordEncoder
		auth.userDetailsService(jwtUserDetailsService).passwordEncoder(passwordEncoder());
	}

	@Bean
	public static PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}

	@Override
	protected void configure(HttpSecurity httpSecurity) throws Exception {
		// We don't need CSRF for this example
		httpSecurity.csrf().disable()
				// dont authenticate this particular request
				.authorizeRequests()
				.antMatchers("/authenticate").permitAll()
				.antMatchers("/register").permitAll()
				.antMatchers("/verify").permitAll()
				.antMatchers("/forgot_password").permitAll()
				.antMatchers("/reset_password").permitAll()
				.antMatchers("/roles").permitAll().antMatchers("/checkEmail/{email}").permitAll()
				.antMatchers("/accept/{idUser}/{idRole}").hasAnyAuthority("Admin", "Super Admin", "SAV Manager")
				.antMatchers("/reject/{idUser}/{idRole}").hasAnyAuthority("Admin", "Super Admin", "SAV Manager")
				.antMatchers("/users").hasAnyAuthority("Admin", "Super Admin", "SAV Manager")
				.antMatchers("/checkUsername/{username}").permitAll().antMatchers("/resend").permitAll()
				// all other requests need to be authenticated
				.anyRequest().authenticated().and().
				// make sure we use stateless session; session won't be used to
				// store user's state.
				exceptionHandling().authenticationEntryPoint(jwtAuthenticationEntryPoint).and().sessionManagement()
				.sessionCreationPolicy(SessionCreationPolicy.STATELESS);

		// Add a filter to validate the tokens with every request
		httpSecurity.addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class);
	}
}
// package com.javainuse.config;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.context.annotation.Bean;
// import org.springframework.context.annotation.Configuration;
// import org.springframework.security.authentication.AuthenticationManager;
// import
// org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
// import
// org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
// import
// org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
// import
// org.springframework.security.config.annotation.web.builders.HttpSecurity;
// import
// org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
// // import
// org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
// import org.springframework.security.config.http.SessionCreationPolicy;
// import org.springframework.security.core.userdetails.UserDetailsService;
// import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
// import org.springframework.security.crypto.password.PasswordEncoder;
// import org.springframework.security.web.SecurityFilterChain;
// import
// org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

// @Configuration
// @EnableWebSecurity
// @EnableGlobalMethodSecurity(prePostEnabled = true)
// public class WebSecurityConfig {

// @Autowired
// private JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;

// @Autowired
// private UserDetailsService jwtUserDetailsService;

// @Autowired
// private JwtRequestFilter jwtRequestFilter;

// /*
// * @Autowired
// * public void configureGlobal(AuthenticationManagerBuilder auth) throws
// * Exception {
// * // configure AuthenticationManager so that it knows from where to load
// * // user for matching credentials
// * // Use BCryptPasswordEncoder
// * auth.userDetailsService(jwtUserDetailsService).passwordEncoder(
// * passwordEncoder());
// * }
// */
// @Bean
// public AuthenticationManager
// authenticationManager(AuthenticationConfiguration
// authenticationConfiguration)
// throws Exception {
// return authenticationConfiguration.getAuthenticationManager();
// }

// @Bean
// public PasswordEncoder passwordEncoder() {
// return new BCryptPasswordEncoder();
// }

// /*
// * @Bean
// *
// * @Override
// * public AuthenticationManager authenticationManagerBean() throws Exception {
// * return super.authenticationManagerBean();
// * }
// */

// /*
// * @Override
// * protected void configure(HttpSecurity httpSecurity) throws Exception {
// * // We don't need CSRF for this example
// * httpSecurity.csrf().disable()
// * // dont authenticate this particular request
// * .authorizeRequests().antMatchers("/authenticate").permitAll().
// * // all other requests need to be authenticated
// * anyRequest().authenticated().and().
// * // make sure we use stateless session; session won't be used to
// * // store user's state.
// *
// exceptionHandling().authenticationEntryPoint(jwtAuthenticationEntryPoint).and
// * ().sessionManagement()
// * .sessionCreationPolicy(SessionCreationPolicy.STATELESS);
// *
// * // Add a filter to validate the tokens with every request
// * httpSecurity.addFilterBefore(jwtRequestFilter,
// * UsernamePasswordAuthenticationFilter.class);
// * }
// */
// @Bean
// public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
// http.cors().and().csrf().disable()
// .exceptionHandling().authenticationEntryPoint(jwtAuthenticationEntryPoint).and()
// .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
// .authorizeRequests()
// .antMatchers("/authenticate").permitAll()
// .anyRequest().authenticated();

// http.addFilterBefore(jwtRequestFilter,
// UsernamePasswordAuthenticationFilter.class);

// return http.build();
// }
// }