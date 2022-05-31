<template>
  <el-container>
    <el-header height="60px">加入考试</el-header>
    <el-main>
      <div>
        <el-input class="input" placeholder="请输入考试标题"></el-input
        ><el-button type="primary" class="button">查询</el-button>
      </div>
      <el-table :data="userAnswers" style="width: 100%">
        <el-table-column prop="exam.id" label="ID" width="120">
        </el-table-column>
        <el-table-column prop="exam.title" label="标题" width="120">
        </el-table-column>
        <el-table-column prop="exam.title" label="科目" width="120">
        </el-table-column>
        <el-table-column prop="exam.duration" label="考试时长" width="120">
        </el-table-column>
        <el-table-column prop="exam.startTime" label="开始时间" width="250">
        </el-table-column>
        <el-table-column prop="exam.endTime" label="结束时间" width="250">
        </el-table-column>
        <el-table-column prop="exam.examPaperName" label="试卷" width="120">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="200">
          <template slot-scope="scope">
            <el-button
              v-if="!isStarted(scope.$index)"
              type="primary"
              size="medium "
            >等待开始</el-button>
            <el-button
              v-else-if="isStarted(scope.$index)&&(userAnswers[scope.$index].status===0||userAnswers[scope.$index].status===2)"
              @click.native.prevent="joinExam(scope.$index)"
              type="danger"
              size="medium "
            >进入考试</el-button>
            <el-button
              v-else-if="userAnswers[scope.$index].status===1"
              size="medium "
              type="primary"
            >等待批阅</el-button>
            <el-button
              v-else-if="userAnswers[scope.$index].status===3"
              size="medium "
              type="primary"
              @click.native.prevent="readResult(scope.$index)"
            >查看结果</el-button>
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
      userAnswers: [],
    };
  },
  methods: {
    getUserAnswers() {
      this.$axios
        .get("/api/userAnswer/getByUserId?")
        .then((res) => {
          this.userAnswers = res.data;
        })
        .catch((err) => {
          this.$message.error("获取用户回答失败");
        });
    },
    joinExam(index) {
      let select = window.confirm(
        "开始考试后不能离开页面，否则会直接交卷！！！"
      );
      if (select === true) {
        this.$router.push({
          name: "exam_view",
          params: { userAnswerId: this.userAnswers[index].id },
        });
      }
    },

    readResult(index) {
      this.$router.push({
        name: "exam_result",
        query: { userAnswerId: this.userAnswers[index].id },
      });
    },

    isStarted(index) {
      let exam = this.userAnswers[index].exam;
      let startTime = exam.startTime;
      let nowDate = new Date();
      let userAnswer;
      if (nowDate.getTime() > new Date(startTime).getTime()) {
        return true;
      }

      return false;
    },
    joined(index) {
      let userAnswer = this.userAnswers[index];
      if (userAnswer.status === 1) {
        return true;
      }
    },
    filter() {
      let temp = [];
      for (userAnswer in this.userAnswers) {
        if (userAnswer.status === 0) {
          temp.push(this.userAnswers);
        }
      }
      this.userAnswers = temp;
    },
  },
  mounted() {
    this.getUserAnswers();
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