package com.javainuse.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

import org.springframework.cloud.openfeign.FeignClient;

import com.javainuse.entities.User;

import feign.Param;
import net.minidev.json.JSONObject;

@FeignClient(name = "NODE-SERVICE")
public interface RegisterNode {

	/*
	 * @RequestMapping(method = RequestMethod.GET, value = "/posts")
	 * List<Post> getPosts();
	 */

	@RequestMapping(method = RequestMethod.POST, value = "/node/register", produces = "application/json")
	User register(@RequestBody JSONObject user);

	@RequestMapping(method = RequestMethod.PUT, value = "/node/accept/{username}/{role}", produces = "application/json")
	User accept(@RequestHeader Map headers, @PathVariable("username") String username,
			@PathVariable("role") String role);

	@RequestMapping(method = RequestMethod.PUT, value = "/node/refuse/{username}/{role}", produces = "application/json")
	User refuse(@RequestHeader Map headers, @PathVariable("username") String username,
			@PathVariable("role") String role);

	@RequestMapping(method = RequestMethod.PUT, value = "/node/removeRoleUser/{role}/{username}", produces = "application/json")
	String removeRole(@RequestHeader Map headers,
			@PathVariable("role") String role,
			@PathVariable("username") String username);

	@RequestMapping(method = RequestMethod.PUT, value = "/node/updateImage/{username}", produces = "application/json")
	User updateImage(@RequestHeader Map headers, @PathVariable("username") String username,
			@RequestBody JSONObject image);

}
