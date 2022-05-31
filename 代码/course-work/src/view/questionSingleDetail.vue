<template>
  <el-container>
    <el-header height="60px">单选题创编</el-header>
    <el-main>
      <el-form label-width="100px">
        <el-form-item label="学科">
          <el-select v-model="question.subjectId">
            <el-option
              v-for="subject in subjects"
              :key="subject.id"
              :label="subject.name"
              :value="subject.id"
            ></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="分数" placeholder="请输入分数">
          <el-input v-model="question.score" style="width: 221px"></el-input>
        </el-form-item>

        <el-form-item label="是否公开">
          <el-select v-model="question.status">
            <el-option label="公开" :value="0"></el-option>
            <el-option label="隐藏" :value="1"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="题干" placeholder="请输入题目内容">
          <el-input
            v-model="content.questionStem"
            style="width: 221px"
          ></el-input>
        </el-form-item>

        <el-form-item label="选项A" placeholder="选项A">
          <el-input
            v-model="content.options[0].content"
            style="width: 221px"
          ></el-input>
        </el-form-item>

        <el-form-item label="选项B" placeholder="选项B">
          <el-input
            v-model="content.options[1].content"
            style="width: 221px"
          ></el-input>
        </el-form-item>

        <el-form-item label="选项C" placeholder="选项C">
          <el-input
            v-model="content.options[2].content"
            style="width: 221px"
          ></el-input>
        </el-form-item>

        <el-form-item label="选项D" placeholder="选项D">
          <el-input
            v-model="content.options[3].content"
            style="width: 221px"
          ></el-input>
        </el-form-item>
        <el-form-item label="答案" placeholder="请输入正确答案">
          <el-select v-model="content.answer">
            <el-option
              v-for="option in content.options"
              :key="option.index"
              :label="option.content"
              :value="option.content"
            ></el-option>
          </el-select>
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
      question: {
        id: "",
        subjectId: "",
        type: "",
        score: "",
        name: "",
        status: "",
        contentId: "",
        subject: { id: "", name: "" },
        content: { id: "", content: "" },
      },
      content: {
        options: [
          { index: "0", content: "" },
          { index: "1", content: "" },
          { index: "2", content: "" },
          { index: "3", content: "" },
        ],
        questionStem: "",
        answer: "",
      },

      option: "add",
      subjects: [],
    };
  },
  methods: {
    getQuestionById() {
      this.$axios
        .get("/api/question/getQuestionById?id=" + this.question.id)
        .then((res) => {
          this.question = res.data;
          this.content = JSON.parse(
            this.question.content.content.replace("\\", "")
          );
        })
        .catch((err) => {
          this.$message.success("读取题目失败");
          console.log(err);
        });
    },
    getAllSubjects() {
      this.$axios
        .get("/api/subject/getAllSubjects")
        .then((res) => {
          this.subjects = res.data;
        })
        .catch((err) => {
          this.$message.success("读取所有科目失败");
          console.log(err);
        });
    },
    submit() {
      if ("edit" === this.option) {
        this.update();
      } else {
        this.add();
      }
    },
    cancel() {
      this.$router.go(-1);
    },
    update() {
      this.question.content.content = JSON.stringify(this.content);
      this.question.name = this.content.questionStem;
      this.$axios
        .post("/api/question/updateQuestion", this.question)
        .then((res) => {
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("更新题目失败");
          console.log(err);
        });
    },
    add() {
      this.question.content.content = JSON.stringify(this.content);
      this.question.name = this.content.questionStem;
      this.$axios
        .post("/api/question/addQuestion", this.question)
        .then((res) => {
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("新增题目失败");
          console.log(err);
        });
    },
  },
  mounted() {
    this.option = this.$route.params.option;
    if ("edit" === this.option) {
      //edit
      this.question.id = this.$route.params.id;
      this.getQuestionById();
      // this.content=JSON.parse(this.question.content.content);在这里执行，数据不一定获取完成，会导致错误
    } else {
      //add
      this.question.type = "单选题";
    }
    this.getAllSubjects();
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