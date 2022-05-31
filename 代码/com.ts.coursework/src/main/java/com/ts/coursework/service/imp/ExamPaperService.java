package com.ts.coursework.service.imp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.ts.coursework.entity.Epqm;
import com.ts.coursework.entity.ExamPaper;
import com.ts.coursework.entity.Question;
import com.ts.coursework.entity.User;
import com.ts.coursework.entity.UserLog;
import com.ts.coursework.mapper.EpqmMapper;
import com.ts.coursework.mapper.ExamPaperMapper;
import com.ts.coursework.mapper.QuestionMapper;
import com.ts.coursework.mapper.TextMapper;
import com.ts.coursework.mapper.UserLogMapper;

@Service
public class ExamPaperService {
	@Autowired
	ExamPaperMapper examPaperMapper;

	@Autowired
	EpqmMapper epqmMapper;
	@Autowired
	QuestionMapper questionMapper;

	@Autowired
	TextMapper textMapper;

	@Autowired
	public UserLogMapper userLogMapper;

	public void addExamPaper(ExamPaper examPaper) {
		User user = getCurrentUser();
		examPaper.setUserId(user.getId());
		examPaperMapper.addExamPaper(examPaper);
		List<Question> questions = examPaper.getQuestions();
		if (questions == null) {
			questions = new ArrayList<Question>();
		}
		for (Question question : questions) {
			Epqm epqm = new Epqm();
			epqm.setExamPaperId(examPaper.getId());
			epqm.setQuestionId(question.getId());
			epqmMapper.add(epqm);
		}

		// 添加日志
		userLogMapper.add(new UserLog(user.getName(), new Date(), "添加了试卷\"" + examPaper.getTitle() + "\""));
	}

	public void delExamPaper(int id) {
		// 数据库会自动删除对应的epqm
		examPaperMapper.delExamPaper(id);
		// 添加日志
		User user = getCurrentUser();
		userLogMapper.add(new UserLog(user.getName(), new Date(), "删除了试卷\"" + id + "\""));
	}

	public void updateExamPaper(ExamPaper examPaper) {
		examPaperMapper.updateExamPaper(examPaper);
		// 先删除所有映射，再添加
		epqmMapper.delByExamPaperId(examPaper.getId());
		List<Question> questions = examPaper.getQuestions();
		if (questions == null) {
			questions = new ArrayList<Question>();
		}
		for (Question question : questions) {
			Epqm epqm = new Epqm();
			epqm.setExamPaperId(examPaper.getId());
			epqm.setQuestionId(question.getId());
			epqmMapper.add(epqm);
		}

		// 添加日志
		User user = getCurrentUser();
		userLogMapper.add(new UserLog(user.getName(), new Date(), "更新了试卷\"" + examPaper.getTitle() + "\""));
	}

	public ExamPaper getExamPaperById(int id) {
		ExamPaper examPaper = examPaperMapper.getExamPaperById(id);
		List<Question> questions = questionMapper.getQuestionsByExamPaperId(id);
		for (Question question : questions) {
			question.setContent(textMapper.getTextById(question.getContentId()));
			;
		}
		examPaper.setQuestions(questions);
		return examPaper;
	}

	public List<ExamPaper> getAllExamPaper() {
		User user = getCurrentUser();
		List<ExamPaper> allExamPapers = examPaperMapper.getAllExamPaper();
		List<ExamPaper> examPapers = null;
		String role = user.getRoles().get(0).getNameZh();
		if ("教师".equals(role)) {
			examPapers = new ArrayList<ExamPaper>();
			for (ExamPaper examPaper : allExamPapers) {
				if (examPaper.getStatus() == 1 || examPaper.getUserId() == user.getId()) {
					List<Question> questions = questionMapper.getQuestionsByExamPaperId(examPaper.getId());
					examPaper.setQuestions(questions);
					examPapers.add(examPaper);
				}
			}
		} else if ("管理员".equals(role)) {
			examPapers = allExamPapers;
			for (ExamPaper examPaper : examPapers) {
				List<Question> questions = questionMapper.getQuestionsByExamPaperId(examPaper.getId());
				examPaper.setQuestions(questions);
			}
		}
		return examPapers;
	}

	public List<ExamPaper> getExamPaperBySubjectId(int subjectId) {
		List<ExamPaper> examPapers = examPaperMapper.getExamPaperBySubjectId(subjectId);
		for (ExamPaper examPaper : examPapers) {
			List<Question> questions = questionMapper.getQuestionsByExamPaperId(examPaper.getId());
			examPaper.setQuestions(questions);
		}
		return examPapers;
	}

	public static User getCurrentUser() {
		return (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	}
}
