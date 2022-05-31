<template>
  <el-container>
    <el-header height="60px">考试报名</el-header>
    <el-main>
      <div>
        <el-input class="input" placeholder="请输入考试标题"></el-input
        ><el-button type="primary" class="button">查询</el-button>
      </div>
      <el-table :data="allExams" style="width: 100%">
        <el-table-column prop="id" label="ID" width="120"> </el-table-column>
        <el-table-column prop="title" label="标题" width="120">
        </el-table-column>
        <el-table-column prop="subjectId" label="科目" width="120">
        </el-table-column>
        <el-table-column prop="duration" label="考试时长" width="120">
        </el-table-column>
        <el-table-column prop="startTime" label="开始时间" width="250">
        </el-table-column>
        <el-table-column prop="endTime" label="结束时间" width="250">
        </el-table-column>
        <el-table-column prop="examPaperId" label="试卷" width="120">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="200">
          <template slot-scope="scope">
            <el-button
              v-if="contain(scope.$index)"
              @click.native.prevent="unsign(scope.$index)"
              type="danger"
              size="medium "
            >
              取消报名
            </el-button>
            <el-button
              v-else
              @click.native.prevent="sign(scope.$index)"
              size="medium "
              type="primary"
            >
              报名
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
      allExams: [],
      //    userExams: [],
      userAnswers: [],
    };
  },
  methods: {
    getAllExams() {
      this.$axios
        .get("/api/exam/getAll")
        .then((res) => {
          this.allExams = res.data;
        })
        .catch((err) => {
          this.$message.error("获取所有考试失败");
        });
    },
    getUserAnswers() {
      this.$axios
        .get("/api/userAnswer/getByUserId")
        .then((res) => {
          this.userAnswers = res.data;
          // this.userAnswers.forEach(userAnswer=>{
          //   this.userExams.push(userAnswer.Exam)
          // })
        })
        .catch((err) => {
          this.$message.error("获取用户考试失败");
        });
    },
    sign(index) {
      let userAnswer = {
        examPaperId: this.allExams[index].examPaperId,
        examId: this.allExams[index].id,
        subjectId:this.allExams[index].subjectId,
      };
      this.$axios
        .post("/api/userAnswer/add?", userAnswer)
        .then((res) => {
          this.getUserAnswers();
        })
        .catch((err) => {
          this.$message.error("报名考试失败");
        });
    },
    unsign(index) {
      let examId = this.allExams[index].id;
      this.userAnswers.forEach((userAnswer) => {
        if ((userAnswer.exam.id = examId)) {
          this.$axios
            .get("/api/userAnswer/del?id="+userAnswer.id)
            .then((res) => {
              this.getUserAnswers();
            })
            .catch((err) => {
              this.$message.error("取消考试失败");
            });
        }
      });
    },
    contain(index) {
      let result = false;
      let examId = this.allExams[index].id;
      this.userAnswers.forEach((userAnswer) => {
        if (userAnswer.exam.id === examId) {
          result = true;
        }
      });
      return result;
    },
    edit(index) {
      this.$router.push({
        name: "exam_edit",
        params: { option: "edit", id: this.tableData[index].id },
      });
    },
  },
  mounted() {
    this.getAllExams();
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