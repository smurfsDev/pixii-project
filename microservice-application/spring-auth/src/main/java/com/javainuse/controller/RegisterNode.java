package com.javainuse.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
    User accept(@PathVariable("username") String username, @PathVariable("role") String role);

    @RequestMapping(method = RequestMethod.PUT, value = "/node/refuse/{username}/{role}", produces = "application/json")
    User refuse(@PathVariable("username") String username, @PathVariable("role") String role);
}
