<template>
  <el-container>
    <el-header height="60px">考试列表</el-header>
    <el-main>
      <div>
        <el-input class="input" placeholder="请输入考试标题"></el-input
        ><el-button type="primary" class="button">查询</el-button>
      </div>
      <el-table :data="tableData" style="width: 100%">
        <el-table-column prop="id" label="ID" width="120"> </el-table-column>
        <el-table-column prop="title" label="标题" width="120">
        </el-table-column>
        <el-table-column prop="subjectName" label="科目" width="120">
        </el-table-column>
        <el-table-column prop="duration" label="考试时长" width="120">
        </el-table-column>
        <el-table-column prop="startTime" label="开始时间" width="250">
        </el-table-column>
        <el-table-column prop="endTime" label="结束时间" width="250">
        </el-table-column>
        <el-table-column prop="examPaperName" label="试卷" width="120">
        </el-table-column>
        <el-table-column prop="userName" label="教师" width="120">
        </el-table-column>
        <el-table-column prop="courseName" label="班级" width="120">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="300">
          <template slot-scope="scope">
            <el-button
              @click.native.prevent="edit(scope.$index)"
              size="medium "
              disabled
            >
              编辑
            </el-button>
            <el-button
              @click.native.prevent="del(scope.$index)"
              type="danger"
              size="medium "
            >
              删除
            </el-button>
            <el-button
              @click.native.prevent="result(scope.$index)"
              type="primary"
              size="medium "
            >
              批阅
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
    };
  },
  methods: {
    getAll() {
      this.$axios
        .get("/api/exam/getAll")
        .then((res) => {
          this.tableData = res.data;
        })
        .catch((err) => {
          this.$message.error("获取所有考试失败");
        });
    },
    del(index) {
      var id = this.tableData[index].id;
      this.$axios
        .get("/api/exam/del?id=" + id)
        .then((res) => {
          this.getAll();
        })
        .catch((err) => {
          this.$message.error("删除考试失败");
          console.log(err);
        });
    },
    edit(index) {
      this.$router.push({
        name: "exam_details",
        params: { option: "edit", id: this.tableData[index].id },
      });
    },
    result(index){
      this.$router.push({name:"mark_paper_list",query:{examId:this.tableData[index].id}})
    }
  },
  mounted() {
    this.getAll();
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