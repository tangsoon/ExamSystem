package com.ts.coursework.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.ts.coursework.entity.UserLog;

@Mapper
public interface UserLogMapper {
	void add(UserLog userLog);
	List<UserLog> getAll();
	
	int getExamPaperSum();
	int getQuestionSum();
	int getAnswerSum();
	int getSubjectSum();
}
