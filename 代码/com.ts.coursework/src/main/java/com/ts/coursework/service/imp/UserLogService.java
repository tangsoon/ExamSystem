package com.ts.coursework.service.imp;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ts.coursework.entity.Statistics;
import com.ts.coursework.entity.UserLog;
import com.ts.coursework.mapper.UserLogMapper;

@Service
public class UserLogService{
	@Autowired
	UserLogMapper userlogMapper;

	public List<UserLog> getAll(){
		return userlogMapper.getAll();
	}

	public Statistics getStatistics(){
		Statistics statistics=new Statistics();
		statistics.setAnswerSum(userlogMapper.getAnswerSum());
		statistics.setExamPaperSum(userlogMapper.getExamPaperSum());
		statistics.setQuestionSum(userlogMapper.getQuestionSum());
		statistics.setSubjectSum(userlogMapper.getSubjectSum());
		return statistics;
	}
}
