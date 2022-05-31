package com.ts.coursework.entity;

import java.util.List;

public class ScoreAnalysis {
	private float maxScore;
	private float minScore;
	private float avgScore;
	private List<Question> questions;
	private float[] questionAccuracy;
	private float[] questionAvgScore;
	public float getMaxScore() {
		return maxScore;
	}
	public void setMaxScore(float maxScore) {
		this.maxScore = maxScore;
	}
	public float getMinScore() {
		return minScore;
	}
	public void setMinScore(float minScore) {
		this.minScore = minScore;
	}
	public float getAvgScore() {
		return avgScore;
	}
	public void setAvgScore(float avgScore) {
		this.avgScore = avgScore;
	}
	public List<Question> getQuestions() {
		return questions;
	}
	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}
	public float[] getQuestionAccuracy() {
		return questionAccuracy;
	}
	public void setQuestionAccuracy(float[] questionAccuracy2) {
		this.questionAccuracy = questionAccuracy2;
	}
	public float[] getQuestionAvgScore() {
		return questionAvgScore;
	}
	public void setQuestionAvgScore(float[] questionAvgScore) {
		this.questionAvgScore = questionAvgScore;
	}
}
