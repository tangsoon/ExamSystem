<template>
  <el-container>
    <el-header height="60px">科目创编</el-header>
    <el-main>
      <el-form class="register_form" label-width="100px">
        <el-form-item label="科目名" placeholder="请输入科目名">
          <el-input v-model="subject.name"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submit" v-show="option != 'read'"
            >提交</el-button
          >
          <el-button type="danger" @click="cancel">取消</el-button>
        </el-form-item>
      </el-form>
    </el-main>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      subject: {
        id: "",
        name: "",
      },
      option: "add",
    };
  },
  methods: {
    submit() {
      if ("edit" === this.option) {
        this.updateSubject();
      } else if ("add" === this.option) {
        this.addSubject();
      }
    },
    cancel() {
      this.$router.go(-1);
    },
    addSubject() {
      this.$axios
        .post("/api/subject/addSubject", this.subject)
        .then((res) => {
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("添加科目失败");
          console.log(err);
        });
    },
    updateSubject() {
      this.$axios
        .post("/api/subject/updateSubject", this.subject)
        .then((res) => {
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("更新科目失败");
          console.log(err);
        });
    },
    getSubjectById(id) {
      this.$axios
        .get("/api/subject/getSubjectById?id=" + id)
        .then((res) => {
          this.subject = res.data;
        })
        .catch((err) => {
          this.$message.success("读取科目失败");
          console.log(err);
        });
    },
  },
  mounted() {
    this.option = this.$route.params.option;
    if ("edit" === this.option) {
      var id = this.$route.params.id;
      this.getSubjectById(id);
    } else {
      this.option = "add";
    }
  },
};
</script>

<style scoped>
.register_form {
  width: 300px;
  margin: 0 auto;
}
.input {
  width: auto;
}
</style>