package com.javainuse.controller;



import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.cloud.openfeign.FeignClient;
import com.javainuse.entities.User;

import net.minidev.json.JSONObject;

@FeignClient(value = "jplaceholder", url = "localhost:8085/node")
public interface JSONPlaceHolderClient {

    /*
     * @RequestMapping(method = RequestMethod.GET, value = "/posts")
     * List<Post> getPosts();
     */

    @RequestMapping(method = RequestMethod.POST, value = "/register", produces = "application/json")
    User registerNode(@RequestBody JSONObject user);
}
