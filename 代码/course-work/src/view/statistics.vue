<template>
  <el-container>
    <el-header height="60px">数据统计</el-header>
    <el-main>
      <h3>试卷总数：{{statistics.examPaperSum}}</h3>
      <h3>题目总数：{{statistics.questionSum}}</h3>
      <h3>答卷总数：{{statistics.answerSum}}</h3>
      <h3>科目总数：{{statistics.subjectSum}}</h3>
    </el-main>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      statistics:{}
    };
  },
  methods: {
    getStatistics() {
      this.$axios
        .get("/api/userLog/getStatistics")
        .then((res) => {
          this.statistics = res.data;
        })
        .catch((err) => {
          this.$message.error("获取统计失败");
          console.log(err);
        });
    },
  },
  mounted() {
    this.getStatistics();
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