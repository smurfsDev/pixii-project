package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.ReactiveDiscoveryClient;
import org.springframework.cloud.gateway.discovery.DiscoveryClientRouteDefinitionLocator;
import org.springframework.cloud.gateway.discovery.DiscoveryLocatorProperties;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.CrossOrigin;

@SpringBootApplication
@CrossOrigin
public class ServiceGatewayApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServiceGatewayApplication.class, args);
	}

	@Bean
	RouteLocator routesLogin(RouteLocatorBuilder builder) {
		return builder.routes()
				.route(r -> r.path(
						"/*/**")
						.and().not(p -> p.path("/node/**"))
						.filters(f -> f.dedupeResponseHeader("Access-Control-Allow-Origin",
								"RETAIN_UNIQUE"))
						.uri("http://localhost:8081"))
				.build();
	}

	@Bean
	RouteLocator routesClaims(RouteLocatorBuilder builder) {
		return builder.routes()
				.route(r -> r.path("/node/**")
						.filters(f -> f.dedupeResponseHeader("Access-Control-Allow-Origin",
								"RETAIN_UNIQUE"))

						.uri("http://localhost:8080"))
				.build();
	}

}
