<template>
  <el-container>
    <el-header height="60px">试卷列表</el-header>
    <el-main>
      <div>
        <el-input class="input" placeholder="请输入试卷标题"></el-input
        ><el-button type="primary" class="button">查询</el-button>
      </div>
      <el-table :data="examPapers" style="width: 100%">
        <el-table-column prop="id" label="ID" width="50"> </el-table-column>
        <el-table-column prop="subjectName" label="科目" width="100">
        </el-table-column>
        <el-table-column prop="title" label="标题" width="200">
        </el-table-column>
        <el-table-column prop="userName" label="教师" width="100">
        </el-table-column>
        <el-table-column label="状态" width="50">
          <template slot-scope="scope">
            {{ examPapers[scope.$index].status === 0 ? "私有" : "公开" }}
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="300">
          <template slot-scope="scope">
            <el-button
            :disabled="user.role != '管理员' && user.id != examPapers[scope.$index].userId"
              @click.native.prevent="edit(scope.$index)"
              size="medium "
            >
              编辑
            </el-button>
            <el-button
            :disabled="user.role != '管理员' && user.id != examPapers[scope.$index].userId"
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
      examPapers: [],
      user:{}
    };
  },
  methods: {
    edit(index) {
      this.$router.push({
        name: "paper_details",
        params: { option: "edit", id: this.examPapers[index].id },
      });
    },
    del(index) {
      this.$axios
        .get("/api/examPaper/delExamPaper?id=" + this.examPapers[index].id)
        .then((res) => {
          this.getAll();
        })
        .catch((err) => {
          this.$message.error("删除试卷失败");
          console.log(err);
        });
    },
    getAll() {
      this.$axios
        .get("/api/examPaper/getAllExamPaper")
        .then((res) => {
          this.examPapers = res.data;
        })
        .catch((err) => {
          this.$message.error("获取所有试卷失败");
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
.button {
  margin: 0 10px;
}
.el-form {
  width: 50%;
  margin: 0 auto;
}
</style>