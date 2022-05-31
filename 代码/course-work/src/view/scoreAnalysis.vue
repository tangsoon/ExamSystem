<template>
  <el-container>
    <el-header height="60px">成绩分析</el-header>
    <el-main>
      <h5>平均分：{{ scoreAnalysis.avgScore }}</h5>
      <h5>最高分：{{ scoreAnalysis.maxScore }}</h5>
      <h5>最低分：{{ scoreAnalysis.minScore }}</h5>
      <el-button type="primary" @click="back()">返回</el-button>

      <el-table :data="questions" style="width: 100%">
        <el-table-column prop="id" label="ID" width="50"> </el-table-column>
        <el-table-column prop="name" label="题目" width="240">
        </el-table-column>
        <el-table-column prop="type" label="类型" width="80"> </el-table-column>
        <el-table-column label="平均分" width="80">
          <template slot-scope="scope">
            {{ questionAvgScore[scope.$index] }}
          </template>
        </el-table-column>
        <el-table-column label="正确率" width="80">
          <template slot-scope="scope">
            {{ questionAccuracy[scope.$index] }}
          </template>
        </el-table-column>

        <el-table-column prop="score" label="分数" width="50">
        </el-table-column>
        <el-table-column prop="name" label="内容" width="240">
        </el-table-column>
        <el-table-column label="状态" width="50">
          <template slot-scope="scope">
            {{ questions[scope.$index].status === 0 ? "私有" : "公开" }}
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="教师" width="100">
        </el-table-column>
      </el-table>
    </el-main>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      examId: {},
      scoreAnalysis: {},
      questions: [],
      questionAccuracy: [],
      questionAvgScore: [],
    };
  },
  methods: {
    getScoreAnalysis() {
      this.$axios
        .get("/api/exam/getScoreAnalysis?examId=" + this.examId)
        .then((res) => {
          this.scoreAnalysis = res.data;
          this.questions = this.scoreAnalysis.questions;
          this.questionAccuracy = this.scoreAnalysis.questionAccuracy;
          this.questionAvgScore = this.scoreAnalysis.questionAvgScore;
        })
        .catch((err) => {
          this.$message.error("分析成绩失败");
          console.log(err);
        });
    },
    back() {
      this.$router.go(-1);
    },
  },
  mounted() {
    this.examId = this.$route.query.examId;
    this.getScoreAnalysis();
  },
};
</script>
<style>
.el-header {
  background-color: #b3c0d1;
  color: #333;
  text-align: center;
  line-height: 60px;
  width: 100%;
  box-shadow: 0 0 2px #000;
}
.input {
  float: left;
  width: 300px;
}
.button {
  margin: 0 10px;
}
</style>