<template>
  <el-container>
    <el-header height="60px">查看日志</el-header>
    <el-main>
      <div>
        <el-input class="input" placeholder="请输入日志"></el-input
        ><el-button type="primary" class="button">查询</el-button>
      </div>
      <el-table :data="userLogs" style="width: 100%">
        <el-table-column prop="userName" label="用户" width="120"> </el-table-column>
        <el-table-column prop="time" label="时间" width="240">
        </el-table-column>
        <el-table-column prop="operation" label="操作" width="240">
        </el-table-column>
      </el-table>
    </el-main>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      userLogs:[]
    };
  },
  methods: {
    getAllUserLogs() {
      this.$axios
        .get("/api/userLog/getAll")
        .then((res) => {
          this.userLogs = res.data;
        })
        .catch((err) => {
          this.$message.error("获取日志失败");
          console.log(err);
        });
    },
  },
  mounted() {
    this.getAllUserLogs();
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