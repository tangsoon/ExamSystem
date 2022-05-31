<template>
  <el-container>
    <el-header height="60px">结果列表</el-header>
    <el-main>
      <div>
        <el-input class="input" placeholder="请输入考试标题"></el-input
        ><el-button type="primary" class="button">查询</el-button>
      </div>
      <el-table :data="userAnswers" style="width: 100%">
        <el-table-column prop="exam.id" label="ID" width="120"> </el-table-column>
        <el-table-column prop="exam.title" label="标题" width="120">
        </el-table-column>
        <el-table-column prop="exam.subjectId" label="科目" width="120">
        </el-table-column>
        <el-table-column prop="exam.duration" label="考试时长" width="120">
        </el-table-column>
        <el-table-column prop="exam.startTime" label="开始时间" width="250">
        </el-table-column>
        <el-table-column prop="exam.endTime" label="结束时间" width="250">
        </el-table-column>
        <el-table-column prop="exam.examPaperId" label="试卷" width="120">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="200">
          <template slot-scope="scope">
            <el-button
              v-if="!joined(scope.$index)&&isStarted(scope.$index)"
              @click.native.prevent=""
              type="danger"
              size="medium "
            >
             等待交卷
            </el-button>
            <el-button
              v-else
              @click.native.prevent="readResult(scope.$index)"
              size="medium "
              type="primary"
            >
              查看结果
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
      userAnswers: [],
    };
  },
  methods: {
    getUserAnswers() {
      this.$axios
        .get("/api/userAnswer/getByExamId?examId="+this.userAnswers.examId)
        .then((res) => {
          this.userAnswers = res.data;
        })
        .catch((err) => {
          this.$message.error("获取用户回答失败");
        });
    },

    readResult(index) {
      this.$router.push({name:"exam_result",params:{userAnswerId:this.userAnswers[index].id}})
    },

    isStarted(index) {
      let exam = this.userAnswers[index].exam;
      let startTime = exam.startTime;
      let nowDate = new Date();
      let userAnswer;
      if (nowDate.getTime()> new Date(startTime).getTime()) {
           return true;
      }

      return false;
    },
    joined(index) {
       let userAnswer=this.userAnswers[index];
       if(userAnswer.status===1){
         return true;
       }
    },
  },
  mounted() {
    this.userAnswers.examId=this.$route.params.examId;
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