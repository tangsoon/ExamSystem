<template>
  <el-container>
    <el-header height="60px">多选题创编</el-header>
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

        <el-form-item :label="'选项'+index" v-for="(option,index) in content.options" :key="index">
          <el-input  :label="option" style="width: 221px" v-model="content.options[index]" ></el-input>
          <el-button type="danger" size="small" @click="delOption(index)">删除</el-button>
        </el-form-item>

        <el-form-item label="答案">
          <el-checkbox-group v-model="content.answers">
            <el-checkbox
              v-for="(option,index) in content.options"
              :key="index"
              :label="option"
             :value="option"
            ></el-checkbox>
          </el-checkbox-group>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="submit">提交</el-button>
          <el-button type="danger" @click="cancel">取消</el-button>
          <el-button type="info" @click="addOption">新增选项</el-button>
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
        options: [""],
        answers: [],
        questionStem: "",
      },

      option: "add",
      subjects: [],
    };
  },
  methods: {
    delOption(index){
     this.content.options.splice(index,index);
    },
    addOption() {
      this.content.options.push("");
    },
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
      this.question.type = "多选题";
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