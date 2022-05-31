<template>
  <el-container style="width: 100%; height: 100%">
    <el-header style="height: 80px">
      <el-button style="height: 100%; background-color: #d9b611; border: 0"
        >返回</el-button
      >
      <span style="">
        剩余:{{
          restTime.h + " 时 " + restTime.m + " 分 " + restTime.s + " 秒 "
        }}
      </span>
    </el-header>
    <el-main class="exam_content">
      <div class="title">{{ userAnswer.exam.title }}</div>
      <div class="subject">科目：{{ userAnswer.subject.name }}</div>
      <div
        v-for="(question, index) in userAnswer.examPaper.questions"
        :key="question.id"
      >
        <div v-if="question.type === '单选题'" class="question_box">
          <p class="stem">{{ index + 1 }}. {{ question.name }}</p>
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
        </div>
        <div v-else-if="question.type === '多选题'" class="question_box">
          <p class="stem">{{ index + 1 }}. {{ question.name }}</p>
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
        </div>

        <div v-else-if="question.type === '判断题'" class="question_box">
          <p class="stem">{{ index + 1 }}. {{ question.name }}</p>
          <el-radio-group v-model="answers[index].content">
            <div
              style="margin: 10px 0"
            >
              <el-radio label="对">对</el-radio>
            </div>

            <div
              style="margin: 10px 0"
            >
              <el-radio label="错">错</el-radio>
            </div>
          </el-radio-group>
        </div>

        <div v-else-if="question.type === '填空题'" class="question_box">
          <p class="stem">{{ index + 1 }}. {{ question.name }}</p>
          <el-input type="textarea" placeholder="答案请用空格隔开" v-model="answers[index].content">
            
          </el-input>
        </div>

        <div v-else-if="question.type === '简答题'" class="question_box">
          <p class="stem">{{ index + 1 }}. {{ question.name }}</p>
          <el-input type="textarea" v-model="answers[index].content" placeholder="请输入答案">
            
          </el-input>
        </div>
      </div>
      <div class="foot">
        <el-button type="primary" @click="submit()">交卷</el-button>
      </div> </el-main
    >
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      examStartTime: "",
      examTotleTime: 60,
      date: new Date(), //当前日期
      restTime: { h: 0, m: 0, s: 0 },
      submited: false,

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
    };
  },
  methods: {
    getUserAnswer() {
      this.$axios
        .get("/api/userAnswer/get?id=" + this.userAnswer.id)
        .then((res) => {
          this.userAnswer = res.data;

          let questions = this.userAnswer.examPaper.questions;
          questions.forEach((question, index) => {
            question.qObject = JSON.parse(
              question.content.content.replace("\\", "")
            );

            //初始化回答
            if (question.type === "单选题") {
              this.answers[index] = {
                questionId: question.id,
                type: question.type,
                content: "",
              };
            } else if (question.type === "多选题") {
              this.answers[index] = {
                questionId: question.id,
                type: question.type,
                content: [],
              };
            } else if (question.type === "判断题") {
              this.answers[index] = {
                questionId: question.id,
                type: question.type,
                content: "",
              };
            } else if (question.type === "填空题") {
              this.answers[index] = {
                questionId: question.id,
                type: question.type,
                content: "",
              };
            } else if (question.type === "简答题") {
              this.answers[index] = {
                questionId: question.id,
                type: question.type,
                content: "",
              };
            }
          });

          //初始化题目格式
        })
        .catch((err) => {
          this.$message.error("获取考生答案失败");
        });
    },
    submit(){
      let tempAnswer=[];
      this.answers.forEach(answer=>{
        if(answer.type==="单选题"){
          tempAnswer.push(answer)
        }
        else if(answer.type==="多选题"){
          tempAnswer.push(answer)
        }
        else if(answer.type==="判断题"){
          tempAnswer.push(answer)
        }
        else if(answer.type==="填空题"){
          let temp={questionId:answer.questionId,type:answer.type,content:answer.content.split(" ")}
          tempAnswer.push(temp)
        }
        else if(answer.type==="简答题"){
          tempAnswer.push(answer)
        }
      })

      this.userAnswer.text.content=JSON.stringify(tempAnswer);
      this.userAnswer.status=1;

      this.$axios.post("/api/userAnswer/update", this.userAnswer)
        .then((res) => {
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.success("交卷失败");
          console.log(err);
        });

      let text=this.userAnswer.text;
    }
  },
  mounted() {
    this.userAnswer.id = this.$route.params.userAnswerId;
    this.getUserAnswer();

    this.examStartTime = new Date();
    var _this = this;
    this.timer = setInterval(() => {
      _this.date = new Date();
      let time =
        _this.examTotleTime * 60 * 1000 -
        (_this.date.getTime() - _this.examStartTime.getTime());
      _this.restTime.h = parseInt(time / 1000 / 60 / 60);
      _this.restTime.m = parseInt(time / 1000 / 60);
      _this.restTime.s = parseInt((time % (1000 * 60)) / 1000);
      if (time <= 0 && _this.userAnswer.status === 0) {
        _this.submited = true;
        _this.submit();
      }
    }, 1000);
  },
  destroyed() {
    this.submit();
  },
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