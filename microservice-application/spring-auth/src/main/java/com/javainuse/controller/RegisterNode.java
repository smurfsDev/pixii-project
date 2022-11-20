package com.javainuse.controller;



import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.cloud.openfeign.FeignClient;
import com.javainuse.entities.User;

import net.minidev.json.JSONObject;

@FeignClient(name="NODE-SERVICE")
public interface RegisterNode {

    /*
     * @RequestMapping(method = RequestMethod.GET, value = "/posts")
     * List<Post> getPosts();
     */

    @RequestMapping(method = RequestMethod.POST, value = "/node/register", produces = "application/json")
    User register(@RequestBody JSONObject user);
}
