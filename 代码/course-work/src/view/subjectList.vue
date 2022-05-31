<template>
  <el-container>
    <el-header height="60px">科目列表</el-header>
    <el-main>
      <div>
        <el-input class="input" placeholder="请输入科目名字"></el-input
        ><el-button type="primary" class="button">查询</el-button>
      </div>
      <el-table :data="subjects" style="width: 100%">
        <el-table-column prop="id" label="ID" width="120"> </el-table-column>
        <el-table-column prop="name" label="科目名" width="240">
        </el-table-column>
        <el-table-column prop="userName" label="创建者" width="240">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="300">
          <template slot-scope="scope">
            <el-button :disabled="user.role!='管理员'&&user.id!=subjects[scope.$index].userId"
              @click.native.prevent="editSubject(scope.$index)"
              size="medium "
            >
              编辑
            </el-button>
            <el-button
            :disabled="user.role!='管理员'&&user.id!=subjects[scope.$index].userId"
              @click.native.prevent="delTableSubject(scope.$index)"
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
      subjects: [],
      user:{}
    };
  },
  methods: {
    getAllSubjects() {
      this.$axios
        .get("/api/subject/getAllSubjects")
        .then((res) => {
          this.subjects = res.data;
        })
        .catch((err) => {
          this.$message.error("获取所有科目失败");
          console.log(err);
        });
    },
    delTableSubject(index) {
      this.delSubject(this.subjects[index].id);
      this.getAllSubjects();
    },
    readSubject(index) {
      this.jumpToSubjectDetails("read", this.subjects[index].id);
    },
    editSubject(index) {
      this.jumpToSubjectDetails("edit", this.subjects[index].id);
    },
    jumpToSubjectDetails(option, id) {
      this.$router.push({
        name: "subject_details",
        params: { option, id },
      }); //option add,read,edit id:userId
    },
    delSubject(id) {
      this.$axios
        .get("/api/subject/delSubject?id=" + id)
        .then((res) => {
          this.getAllSubjects();
        })
        .catch((err) => {
          this.$message.error("删除科目失败");
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
    }
  },
  mounted() {
    this.getAllSubjects();
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