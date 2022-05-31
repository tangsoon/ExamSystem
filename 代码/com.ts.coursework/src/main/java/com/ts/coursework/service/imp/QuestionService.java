package com.ts.coursework.service.imp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import com.ts.coursework.entity.Question;
import com.ts.coursework.entity.Subject;
import com.ts.coursework.entity.Text;
import com.ts.coursework.entity.User;
import com.ts.coursework.entity.UserLog;
import com.ts.coursework.mapper.QuestionMapper;
import com.ts.coursework.mapper.SubjectMapper;
import com.ts.coursework.mapper.TextMapper;
import com.ts.coursework.mapper.UserLogMapper;

@Service
public class QuestionService {
	@Autowired
	QuestionMapper questionMapper;
	
	@Autowired
	TextMapper textMapper;
	
	@Autowired
	SubjectMapper subjectMapper;
	
	@Autowired
	public UserLogMapper userLogMapper;
	
	public void addQuestion(Question question) {
		User user=getCurrentUser();
		question.setUserId(user.getId());
		Text content=question.getContent();
		textMapper.addText(content);
		question.setContentId(content.getId());
		questionMapper.addQuestion(question);
		userLogMapper.add(new UserLog(user.getName(),new Date(),"添加了题目\""+question.getName()+"\""));
	}
	public void delQuestion(int id) {
		Question question=questionMapper.getQuestionById(id);
		int contentId=question.getContentId();
		textMapper.delText(contentId);
		questionMapper.delQuestion(id);
		
		User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//添加日志
				userLogMapper.add(new UserLog(user.getName(),new Date(),"删除了题目\""+id+"\""));
	}
	public 	void updateQuestion(Question question) {
		Text content=question.getContent();
		textMapper.updateText(content);
		questionMapper.updateQuestion(question);
		

		User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//添加日志
		userLogMapper.add(new UserLog(user.getName(),new Date(),"更新了题目\""+question.getName()+"\""));
	}
	public Question getQuestionById(int id) {
		Question question= questionMapper.getQuestionById(id);
		Text text=textMapper.getTextById(question.getContentId());
		question.setContent(text);
		Subject subject=subjectMapper.getSubjectById(question.getSubjectId());
		question.setSubject(subject);
		return question;
	}
	public List<Question> getAllQuestions() {
		User user=getCurrentUser();
		List<Question> result= questionMapper.getAllQuestions();

		if(user.getRoles().get(0).getNameZh().equals("管理员")) {
			for(Question question:result) {
				Text text=textMapper.getTextById(question.getContentId());
				question.setContent(text);
				Subject subject=subjectMapper.getSubjectById(question.getSubjectId());
				question.setSubject(subject);
			}
			return result;
		}
		else {
			List<Question> questions=new ArrayList<Question>();
			for(Question question:result) {
				if(question.getUserId()==user.getId()||question.getStatus()==1) {
					questions.add(question);
					Text text=textMapper.getTextById(question.getContentId());
					question.setContent(text);
					Subject subject=subjectMapper.getSubjectById(question.getSubjectId());
					question.setSubject(subject);
				}
			}
			return questions;
		}
	}
	
	public List<Question> getQuestionsByExamPaperId(int examPaperId){
		List<Question> questions= questionMapper.getQuestionsByExamPaperId(examPaperId);
		for(Question question:questions) {
			Text text=textMapper.getTextById(question.getContentId());
			question.setContent(text);
			Subject subject=subjectMapper.getSubjectById(question.getSubjectId());
			question.setSubject(subject);
		}
		return questions;
	}
	
	public List<Question> getQuestionsBySubjectId(int subjectId){
		User user=getCurrentUser();
		List<Question> result= questionMapper.getQuestionsBySubjectId(subjectId);
		
		if(user.getRoles().get(0).getNameZh().equals("管理员")) {
			for(Question question:result) {
				Text text=textMapper.getTextById(question.getContentId());
				question.setContent(text);
				Subject subject=subjectMapper.getSubjectById(question.getSubjectId());
				question.setSubject(subject);
			}
			return result;
		}
		else {
			List<Question> questions=new ArrayList<Question>();
			for(Question question:result) {
				if(question.getUserId()==user.getId()||question.getStatus()==1) {
					questions.add(question);
					Text text=textMapper.getTextById(question.getContentId());
					question.setContent(text);
					Subject subject=subjectMapper.getSubjectById(question.getSubjectId());
					question.setSubject(subject);
				}
			}
			return questions;
		}
	}
	
	public static User getCurrentUser() {
		return (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	}
}
