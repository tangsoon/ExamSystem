<template>
  <el-container>
    <el-header height="60px">题目列表</el-header>
    <el-main>
      <div>
        <el-input class="input" placeholder="请输入题目名字"></el-input
        ><el-button type="primary" class="button">查询</el-button>
      </div>
      <el-table :data="tableData" style="width: 100%">
        <el-table-column prop="id" label="ID" width="50"> </el-table-column>
        <el-table-column prop="subjectName" label="科目" width="80">
        </el-table-column>
        <el-table-column prop="type" label="类型" width="80"> </el-table-column>
        <el-table-column prop="score" label="分数" width="50">
        </el-table-column>
        <el-table-column prop="name" label="内容" width="240">
        </el-table-column>
        <el-table-column label="状态" width="50">
          <template slot-scope="scope">
            {{ tableData[scope.$index].status === 0 ? "私有" : "公开" }}
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="教师" width="100">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="200">
          <template slot-scope="scope">
            <el-button
              :disabled="
                user.role != '管理员' &&
                user.id != tableData[scope.$index].userId
              "
              @click.native.prevent="edit(scope.$index)"
              size="medium "
            >
              编辑
            </el-button>
            <el-button
              :disabled="
                user.role != '管理员' &&
                user.id != tableData[scope.$index].userId
              "
              @click.native.prevent="del(scope.$index)"
              type="danger"
              size="medium "
            >
              删除
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
      tableData: [],
      user: {},
    };
  },
  methods: {
    getAll() {
      this.$axios
        .get("/api/question/getAllQuestions")
        .then((res) => {
          this.tableData = res.data;
        })
        .catch((err) => {
          this.$message.error("获取所有题目失败");
          console.log(err);
        });
    },
    del(index) {
      var id = this.tableData[index].id;
      this.$axios
        .get("/api/question/delQuestion?id=" + id)
        .then((res) => {
          this.getAll();
        })
        .catch((err) => {
          this.$message.error("删除题目失败");
          console.log(err);
        });
    },
    edit(index) {
      var question = this.tableData[index];
      var type = question.type;
      var id = question.id;
      var option = "edit";
      if ("单选题" === type) {
        this.$router.push({
          name: "question_single_choice_edit",
          params: { option, id },
        }); //option add,edit id
      } else if ("多选题" === type) {
        this.$router.push({
          name: "question_multiple_choice_edit",
          params: { option, id },
        });
      } else if ("判断题" === type) {
        this.$router.push({
          name: "quesiton_true_false_edit",
          params: { option, id },
        });
      } else if ("填空题" === type) {
        this.$router.push({
          name: "quesiton_filling_edit",
          params: { option, id },
        });
      } else if ("简答题" === type) {
        this.$router.push({
          name: "questin_short_answer_edit",
          params: { option, id },
        });
      } else {
        this.$message.error("未知的题目类型");
      }
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
    this.getAll();
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
.input {
  float: left;
  width: 300px;
}
.button {
  margin: 0 10px;
}
</style>