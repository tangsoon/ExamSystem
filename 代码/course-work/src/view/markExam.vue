<template>
  <el-container style="width: 100%; height: 100%">
    <el-header style="height: 80px">
      <el-button
        style="height: 100%; background-color: #d9b611; border: 0"
        @click="cancel()"
        >返回</el-button
      >
    </el-header>
    <el-main class="exam_content">
      <div class="title">{{ userAnswer.exam.title }}</div>
      <div class="subject">科目：{{ userAnswer.subject.name }}</div>
      <div class="subject">得分：{{ userAnswer.score }}</div>
      <div
        v-for="(question, index) in userAnswer.examPaper.questions"
        :key="question.id"
      >
        <div v-if="question.type === '单选题'" class="question_box">
          <p class="stem">
            {{ index + 1 }}. {{ question.name }}（分数：{{ question.score }}）
          </p>
          <el-radio-group v-model="answers[index].content">
            <div
              v-for="(option, index) in question.qObject.options"
              :key="index"
              :value="option.content"
              style="margin: 10px 0"
            >
              <el-radio :label="option.content">{{ option.content }}</el-radio>
            </div>
          </el-radio-group>
          <p>正确答案：{{ question.qObject.answer }}</p>
        </div>
        <div v-else-if="question.type === '多选题'" class="question_box">
          <p class="stem">
            {{ index + 1 }}. {{ question.name }}（分数：{{ question.score }}）
          </p>
          <el-checkbox-group v-model="answers[index].content">
            <div
              v-for="(option, index) in question.qObject.options"
              :key="index"
              :value="option.content"
              style="margin: 10px 0"
            >
              <el-checkbox :label="option" :v="option"> </el-checkbox>
            </div>
          </el-checkbox-group>
          <p>正确答案：{{ question.qObject.answers }}</p>
        </div>

        <div v-else-if="question.type === '判断题'" class="question_box">
          <p class="stem">
            {{ index + 1 }}. {{ question.name }}（分数：{{ question.score }}）
          </p>
          <el-radio-group v-model="answers[index].content">
            <div style="margin: 10px 0">
              <el-radio label="对">对</el-radio>
            </div>

            <div style="margin: 10px 0">
              <el-radio label="错">错</el-radio>
            </div>
          </el-radio-group>
          <p>正确答案：{{ question.qObject.answer }}</p>
        </div>

        <div v-else-if="question.type === '填空题'" class="question_box">
          <p class="stem">
            {{ index + 1 }}. {{ question.name }}（分数：{{ question.score }}）
          </p>
          <el-input
            type="textarea"
            placeholder="答案请用空格隔开"
            v-model="answers[index].content"
          >
          </el-input>
          <p>正确答案：{{ question.qObject.answers }}</p>
          <el-input placeholder="请输入分数" v-model="score[index]"></el-input>
        </div>

        <div v-else-if="question.type === '简答题'" class="question_box">
          <p class="stem">
            {{ index + 1 }}. {{ question.name }}（分数：{{ question.score }}）
          </p>
          <el-input
            type="textarea"
            v-model="answers[index].content"
            placeholder="请输入答案"
          >
          </el-input>
          <p>正确答案：{{ question.qObject.answer }}</p>
          <el-input placeholder="请输入分数" v-model="score[index]"></el-input>
        </div>
      </div>
      <div class="foot">
        <el-button type="danger" @click="submit()">提交</el-button>
      </div>
    </el-main>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      userAnswer: {
        id: "",
        textId: "",
        examPaperId: "",
        subjectId: "",
        status: "",
        userId: "",
        examId: "",
        status: "",
        text: {},
        user: {},
        exam: { title: " " },
        examPaper: { questinos: [{ name: " " }] },
        subject: { name: " " },
      },
      answers: [],
      score:[]
    };
  },
  methods: {
    getUserAnswer() {
      this.$axios
        .get("/api/userAnswer/get?id=" + this.userAnswer.id)
        .then((res) => {
          this.userAnswer = res.data;

          let questions = this.userAnswer.examPaper.questions;
          let tempAnswers = JSON.parse(
            this.userAnswer.text.content.replace("\\", "")
          );
          questions.forEach((question, index) => {
            question.qObject = JSON.parse(
              question.content.content.replace("\\", "")
            );

            //初始化回答
            if (question.type === "单选题") {
              this.answers[index] = {
                questionId: question.id,
                type: question.type,
                content: tempAnswers[index].content,
              };
            } else if (question.type === "多选题") {
              this.answers[index] = {
                questionId: question.id,
                type: question.type,
                content: tempAnswers[index].content,
              };
            } else if (question.type === "判断题") {
              this.answers[index] = {
                questionId: question.id,
                type: question.type,
                content: tempAnswers[index].content,
              };
            } else if (question.type === "填空题") {
              this.answers[index] = {
                questionId: question.id,
                type: question.type,
                content: tempAnswers[index].content.join(" "),
              };
            } else if (question.type === "简答题") {
              this.answers[index] = {
                questionId: question.id,
                type: question.type,
                content: tempAnswers[index].content,
              };
            }
          });

          //初始化题目格式
        })
        .catch((err) => {
          this.$message.error("获取考生答案失败");
        });
    },
    submit() {
      //计算总分
      var score=0;
      for (var i=0;i<this.userAnswer.examPaper.questions.length;i++) {
        if(this.score[i]!=null&&this.score[i]!=undefined){
          score += parseInt(this.score[i]);
          
        }
      }
      this.userAnswer.score = score;
      //更改答卷状态
      this.userAnswer.status = 3;
      //提交
      this.$axios
        .post("/api/userAnswer/mark", this.userAnswer)
        .then((res) => {
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("批改失败");
          console.log(err);
        });
    },
  },
  mounted() {
    this.userAnswer.id = this.$route.query.userAnswerId;
    this.getUserAnswer();
  },
  destroyed() {},
};
</script>
<style scoped>
.exam_content {
  width: 100%;
  height: 90%;
  background-color: #eedeb0;
}
.title {
  text-align: center;
  font-size: 40px;
  padding: 10px 10px;
}
.subject {
  text-align: center;
  font-size: 20px;
  padding: 10px 10px;
}
.question_box {
  width: 80%;
  padding: 20px 20px;
  border: solid 1px #d9b611;
  margin: 10px auto;
  border-radius: 5px;
}
.el-header {
  background-color: #eacd76;
  color: #333;
  text-align: left;
  line-height: 60px;
  width: 100%;
  -webkit-box-shadow: 0 0 2px #000;
  box-shadow: 0 0 2px #000;
  padding: 0;
}

.foot .el-button--primary {
  color: #fff;
  background-color: #f0c239;
  border-color: #d9b611;
}
.foot {
  width: 0%;
  padding: 20px 20px;
  margin: 10px auto;
  border-radius: 5px;
}
</style>