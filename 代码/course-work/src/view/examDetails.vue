<template>
  <el-container>
    <el-header height="60px">考试创编</el-header>
    <el-main>
      <el-form label-width="100px">
        <el-form-item label="考试标题">
          <el-input
            v-model="exam.title"
            style="width: 221px"
            placeholder="请输入考试标题"
          ></el-input>
        </el-form-item>

        <el-form-item label="考试科目">
          <el-select
            v-model="exam.subjectId"
            @change="getExamPaperBySubjectId()"
          >
            <el-option
              v-for="subject in subjects"
              :key="subject.id"
              :value="subject.id"
              :label="subject.name"
            ></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="试卷">
          <el-select v-model="exam.examPaperId">
            <el-option
              v-for="paper in subjectExamPapers"
              :key="paper.id"
              :value="paper.id"
              :label="paper.title"
            ></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="开始时间">
          <el-date-picker
            v-model="dates"
            type="datetimerange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
          >
          </el-date-picker>
        </el-form-item>

        <el-form-item label="参考班级">
          <el-select v-model="exam.courseId">
            <el-option
              v-for="course in courses"
              :key="course.id"
              :value="course.id"
              :label="course.name"
            ></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="考试时长">
          <el-input
            v-model="exam.duration"
            style="width: 221px"
            placeholder="请输入持续时间（分钟）"
            onkeyup="value=value.replace(/[^\d]/g,'')"
          ></el-input>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="submit">提交</el-button>
          <el-button type="danger" @click="cancel">取消</el-button>
        </el-form-item>
      </el-form>
    </el-main>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      op: "add",
      exam: {
        id: "",
        title: "",
        examPaperId: "",
        subjectId: "",
        startTime: "",
        endTime: "",
        duration: "",
      },
      courses: [],
      subjects: [],
      subjectExamPapers: [],
      dates: [new Date(), new Date()],
    };
  },

  methods: {
    update() {
      this.$axios
        .post("/api/exam/update", this.exam)
        .then((res) => {
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("更新考试失败");
          console.log(err);
        });
    },
    add() {
      this.$axios
        .post("/api/exam/add", this.exam)
        .then((res) => {
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("新增考试失败");
        });
    },
    submit() {
      this.exam.startTime = this.dates[0];
      this.exam.endTime = this.dates[1];
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

    getExamPaperBySubjectId() {
      this.$axios
        .get(
          "/api/examPaper/getExamPaperBySubjectId?subjectId=" +
            this.exam.subjectId
        )
        .then((res) => {
          this.subjectExamPapers = res.data;
        })
        .catch((err) => {
          this.$message.error("读取对应科目的试卷失败");
        });
    },

    get() {
      this.$axios
        .get("/api/exam/get?id=" + this.exam.id)
        .then((res) => {
          this.exam = res.data;
          //获取考试的科目成功后，再获取对应科目的试卷，供用户选择
          this.getExamPaperBySubjectId();
          //设置时间，
          this.dates = [this.exam.startTime, this.exam.endTime];
        })
        .catch((err) => {
          this.$message.error("读取考试失败");
          console.log(err);
        });
    },
    getUserCourses() {
      this.$axios
        .get("/api/course/getUserCourses?")
        .then((res) => {
          this.courses = res.data;
        })
        .catch((err) => {
          this.$message.error("读取课堂失败");
          console.log(err);
        });
    },
  },
  mounted() {
    this.op = this.$route.params.option;
    if ("edit" === this.op) {
      this.exam.id = this.$route.params.id;
      this.get();
    } else {
    }
    this.getAllSubjects();
    this.getUserCourses();
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