package com.javainuse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.javainuse.service.UserService;

import net.minidev.json.JSONObject;

@RestController
@CrossOrigin
public class VerificationController {
    @Autowired
    private UserService service;

    @PostMapping("/verify")
    public ResponseEntity<JSONObject> verifyUser(@RequestBody JSONObject req) {
        JSONObject res = new JSONObject();
        ResponseEntity<JSONObject> response = null;
        if (req.containsKey("code") && req.containsKey("email")) {
            try {
                service.verify(req.getAsString("email"), req.getAsString("code"));
                res.put("message", "User verified successfully");
                response = ResponseEntity.ok(res);
            } catch (Exception e) {
                res.put("message", e.getMessage());
                response = ResponseEntity.badRequest().body(res);
            }
        } else {
            res.put("message", "Invalid request, email or code is missing");
            response = ResponseEntity.status(400).body(res);
        }

        return response;
    }
}
