package com.ts.coursework.service.imp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import com.ts.coursework.entity.Exam;
import com.ts.coursework.entity.Question;
import com.ts.coursework.entity.ScoreAnalysis;
import com.ts.coursework.entity.User;
import com.ts.coursework.entity.UserAnswer;
import com.ts.coursework.entity.UserLog;
import com.ts.coursework.mapper.ExamMapper;
import com.ts.coursework.mapper.UserLogMapper;
@Service
public class ExamService {
	
	@Autowired
	ExamMapper examMapper;
	
	@Autowired
	UserAnswerService userAnswerService;

	@Autowired
	UserService userService;
	
	@Autowired
	QuestionService questionService;
	
	@Autowired
	public UserLogMapper userLogMapper;
	
	public void add(Exam exam) {
		User user=getCurrentUser();
		exam.setUserId(user.getId());
		examMapper.add(exam);
		userAnswerService.createAnswersForExam(exam);
		
		//添加日志
				userLogMapper.add(new UserLog(user.getName(),new Date(),"添加了考试\""+exam.getTitle()+"\""));
	}
	
	public void del(int id) {
		//TODO-删除userAnswer
		Exam exam=this.get(id);
		userAnswerService.delAnswersForExam(exam);
		examMapper.del(id);
		
		//添加日志
		User user=this.getCurrentUser();
		userLogMapper.add(new UserLog(user.getName(),new Date(),"删除了考试\""+id+"\""));
	}
	
	public void update(Exam exam) {
		//TODO-更新userAnswer
		userAnswerService.updateAnswersForExam(exam);
		examMapper.update(exam);
		

		//添加日志
		User user=this.getCurrentUser();
		userLogMapper.add(new UserLog(user.getName(),new Date(),"更新了了考试\""+exam.getTitle()+"\""));
	}
	
	public Exam get(int id) {
		Exam exam=examMapper.get(id);
		return exam;
	}
	
	public List<Exam> getAll(){
		User user = this.getCurrentUser();
		String role=user.getRoles().get(0).getNameZh();
		List<Exam> exams=null;
		if("教师".equals(role)) {
			exams=examMapper.getExamsByUserId(user.getId());
		}
		else if("管理员".equals(role)) {
			exams=examMapper.getAll();
		}
		if(exams==null) {
			exams=new ArrayList<Exam>();
		}
		
		return exams;
	}
	
	public List<Exam> getBySubjectId(int subjectId){
		return examMapper.getBySubjectId(subjectId);
	}
	
	public List<Exam> getExamsByUserId(long userId){
		return examMapper.getExamsByUserId(userId);
	}
	
	public User getCurrentUser() {
		return (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	}
	
	public ScoreAnalysis getScoreAnalysis(int examId){
		ScoreAnalysis analysis=new ScoreAnalysis();
		List<UserAnswer> userAnswers=userAnswerService.getByExamId(examId);
		Exam exam=this.get(examId);
		List<Question> questions=questionService.getQuestionsByExamPaperId(exam.getExamPaperId());
		analysis.setQuestions(questions);
		float max=userAnswers.get(0).getScore();
		float min=userAnswers.get(0).getScore();
		float sum=0;
		for(int i=1;i<userAnswers.size();i++) {
			UserAnswer userAnswer=userAnswers.get(i);
			float score=userAnswer.getScore();
			if(max<score) {
				max=score;
			}
			if(min>score) {
				min=score;
			}
			sum+=score;
		}
		float avgScore=sum/userAnswers.size();
		analysis.setMaxScore(max);
		analysis.setMinScore(min);
		analysis.setAvgScore(avgScore);
		float[] questionAccuracy=new float[questions.size()];
		float[] questionAvgScore=new float[questions.size()];
		
		//待实现
		Random random=new Random();
		for(int i=0;i<questions.size();i++) {
			questionAccuracy[i]=((int)(random.nextFloat()*100F))/100F;
			questionAvgScore[i]=((int)(random.nextFloat()*100F));
		}
		analysis.setQuestionAccuracy(questionAccuracy);
		analysis.setQuestionAvgScore(questionAvgScore);
		return analysis;
	}
}
