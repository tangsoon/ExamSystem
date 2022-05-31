<template>
  <el-container>
    <el-header height="60px">试卷创编</el-header>
    <el-main>
      <el-form label-width="100px">
        <el-form-item label="试卷标题">
          <el-input
            v-model="examPaper.title"
            style="width: 221px"
            placeholder="请输入标题"
          ></el-input>
        </el-form-item>

        <el-form-item label="试卷科目">
          <el-select
            v-model="examPaper.subjectId"
            @change="getQuestionsBySubjectId"
          >
            <el-option
              v-for="subject in subjects"
              :key="subject.id"
              :value="subject.id"
              :label="subject.name"
            ></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="是否公开">
          <el-select
            v-model="examPaper.status"
          >
          <el-option label="公开" value="1"></el-option>
          <el-option label="私有" value="0"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="submit">提交</el-button>
          <el-button type="danger" @click="cancel">取消</el-button>
        </el-form-item>
      </el-form>

      <el-table
        :data="subjectQuestions"
        ref="table"
        style="width: 100%"
        height="500px"
      >
        <el-table-column prop="id" label="ID" width="50"></el-table-column>
        <el-table-column prop="subjectName" label="科目" width="100">
        </el-table-column>
        <el-table-column prop="type" label="类型" width="80">
        </el-table-column>
        <el-table-column prop="score" label="分数" width="50">
        </el-table-column>
        <el-table-column prop="name" label="内容" width="240">
        </el-table-column>
        <el-table-column prop="status" label="状态" width="50">
          <template slot-scope="scope">
            {{ subjectQuestions[scope.$index].status === 0 ? "私有" : "公开" }}
          </template>
        </el-table-column>        
        <el-table-column prop="userName" label="教师" width="100">
        </el-table-column>

        <el-table-column fixed="right" label="操作" width="300">
          <template slot-scope="scope">
            <el-button
              v-if="containQuestion(scope.$index)"
              @click.native.prevent="delQuestion(scope.$index)"
              type="danger"
              size="medium "
            >
              移除
            </el-button>
            <el-button
              v-else
              @click.native.prevent="addQuestion(scope.$index)"
              size="medium "
              type="primary"
            >
              添加
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
      op: "add",
      examPaper: { id: "", subjectId: "", title: "", questions: [] },
      subjects: [],
      subjectQuestions: [],
      user:{},
    };
  },

  methods: {
    addQuestion(index) {
      this.examPaper.questions.push(this.subjectQuestions[index]);
    },
    delQuestion(idnex) {
      let qId = this.subjectQuestions[idnex].id;
      this.examPaper.questions.forEach((question, index, arr) => {
        if (question.id === qId) {
          arr.splice(index, 1);
        }
      });
    },
    containQuestion(index) {
      let result = false;
      let qId = this.subjectQuestions[index].id;
      this.examPaper.questions.forEach((question) => {
        if (question.id === qId) {
          result = true;
        }
      });
      return result;
    },
    update() {
      this.$axios
        .post("/api/examPaper/updateExamPaper", this.examPaper)
        .then((res) => {
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("更新试卷失败");
          console.log(err);
        });
    },
    add() {
      this.$axios
        .post("/api/examPaper/addExamPaper", this.examPaper)
        .then((res) => {
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("新增试卷失败");
          console.log(err);
        });
    },
    submit() {
      if ("edit" === this.op) {
        this.update();
      } else {
        this.add();
      }
    },
    cancel() {
      this.$router.go(-1);
    },
    getAllSubjects() {
      this.$axios
        .get("/api/subject/getAllSubjects")
        .then((res) => {
          this.subjects = res.data;
        })
        .catch((err) => {
          this.$message.error("读取所有科目失败");
          console.log(err);
        });
    },

    getQuestionsBySubjectId() {
      this.$axios
        .get(
          "/api/question/getQuestionsBySubjectId?subjectId=" +
            this.examPaper.subjectId
        )
        .then((res) => {
          this.subjectQuestions = res.data;
        })
        .catch((err) => {
          this.$message.error("读取对应科目的题目失败");
          console.log(err);
        });
    },

    getExamPaperById() {
      this.$axios
        .get("/api/examPaper/getExamPaperById?id=" + this.examPaper.id)
        .then((res) => {
          this.examPaper = res.data;

          this.getQuestionsBySubjectId();
        })
        .catch((err) => {
          this.$message.error("读取试卷失败");
          console.log(err);
        });
    },
    getCurrentUser() {
      this.$axios
        .get("api/register/getCurrentUser")
        .then((res) => {
          this.user = res.data;
        })
        .catch((err) => {
          this.$message.error("获取用户信息失败");
        });
    },
  },
  mounted() {
    this.op = this.$route.params.option;
    if ("edit" === this.op) {
      this.examPaper.id = this.$route.params.id;
      this.getExamPaperById();
    } else {
    }
    this.getAllSubjects();
    this.getCurrentUser();
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
.button {
  margin: 0 10px;
}
.el-form {
  width: 50%;
  margin: 0 auto;
}
</style>