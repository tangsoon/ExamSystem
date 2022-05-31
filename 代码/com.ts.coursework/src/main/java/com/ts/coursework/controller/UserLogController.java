package com.ts.coursework.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ts.coursework.entity.Statistics;
import com.ts.coursework.entity.UserLog;
import com.ts.coursework.service.imp.UserLogService;

@RestController
@CrossOrigin(allowCredentials = "true")
@RequestMapping("/userLog")
public class UserLogController {
	
	@Autowired
	public UserLogService userLogService;
	
	@CrossOrigin
	@GetMapping("/getAll")
	public List<UserLog> getAll(){
		return userLogService.getAll();
	}
	
	@CrossOrigin
	@GetMapping("/getStatistics")
	public Statistics getStatistics(){
		return userLogService.getStatistics();
	}
}
