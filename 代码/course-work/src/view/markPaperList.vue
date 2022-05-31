<template>
  <el-container>
    <el-header height="60px">批阅试卷</el-header>
    <el-main>
      <div>
        <el-input class="input" placeholder="请输入考生名字"></el-input
        ><el-button type="primary" class="button">查询</el-button
        ><el-button type="primary" class="button" @click="jumpToAnalysis()"
          >成绩分析</el-button
        >
      </div>
      <h3>{{ exam.title }}</h3>
      <h5>班级：{{ exam.courseName }} {{ exam.className }}</h5>
      <h5>科目：{{ exam.subjectName }}</h5>
      <el-table :data="userAnswers" style="width: 100%">
        <el-table-column prop="userName" label="名字" width="220">
        </el-table-column>
        <el-table-column prop="userId" label="学号" width="220">
        </el-table-column>
        <el-table-column label="状态" width="220">
          <template slot-scope="scope">
            {{
              userAnswers[scope.$index].status === 0
                ? "待提交"
                : userAnswers[scope.$index].status === 1
                ? "待批改"
                : userAnswers[scope.$index].status === 2
                ? "被打回"
                : "已批改"
            }}
          </template>
        </el-table-column>
        <el-table-column prop="score" label="成绩" width="220">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="100">
          <template slot-scope="scope">
            <el-button
              type="primary"
              @click.native.prevent="markExam(scope.$index)"
              size="medium "
              :disabled="userAnswers[scope.$index].status === 0"
            >
              批改
            </el-button>
          </template>
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
      exam: {},
      userAnswers: [],
    };
  },
  methods: {
    getExamById() {
      this.$axios
        .get("/api/exam/get?id=" + this.examId)
        .then((res) => {
          this.exam = res.data;
        })
        .catch((err) => {
          this.$message.error("读取考试信息失败");
          console.log(err);
        });
    },
    getUserAnswersByExamId() {
      this.$axios
        .get("/api/userAnswer/getByExamId?examId=" + this.examId)
        .then((res) => {
          this.userAnswers = res.data;
        })
        .catch((err) => {
          this.$message.error("读取答题信息失败");
          console.log(err);
        });
    },
    markExam(index) {
      this.$router.push({
        name: "mark_exam",
        query: { userAnswerId: this.userAnswers[index].id },
      });
    },
    jumpToAnalysis() {
      this.$router.push({
        name: "score_analysis",
        query: { examId:this.examId },
      });
    },
  },
  mounted() {
    this.examId = this.$route.query.examId;
    this.getExamById();
    this.getUserAnswersByExamId();
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