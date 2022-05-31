package com.ts.coursework.service.imp;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.ts.coursework.entity.Subject;
import com.ts.coursework.entity.User;
import com.ts.coursework.entity.UserLog;
import com.ts.coursework.mapper.SubjectMapper;
import com.ts.coursework.mapper.UserLogMapper;

@Service
public class SubjectService {

	@Autowired
	public SubjectMapper subjectMapper;
	
	@Autowired
	public UserLogMapper userLogMapper;
	
	public void addSubject(Subject subject) {
		User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		subject.setUserId(user.getId());
		subjectMapper.addSubject(subject);
		//添加日志
		userLogMapper.add(new UserLog(user.getName(),new Date(),"添加了科目\""+subject.getName()+"\""));
	}
	public void delSubject(int id) {
		User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		subjectMapper.delSubject(id);
		//添加日志
		userLogMapper.add(new UserLog(user.getName(),new Date(),"删除了科目\""+id+"\""));
	}
	public void updateSubject(Subject subject) {
		User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		subjectMapper.updateSubject(subject);
		//添加日志
				userLogMapper.add(new UserLog(user.getName(),new Date(),"更新了科目\""+subject.getName()+"\""));
	}
	public Subject getSubjectById(int id) {
	 return 	subjectMapper.getSubjectById(id);
	}
	
	public List<Subject> getAllSubjects(){
		return subjectMapper.getAllSubjects();
	}
}
