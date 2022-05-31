<template>
  <el-form class="register_form" label-width="100px">
    <el-form-item label="身份">
      <el-select v-model="user.role">
        <el-option value="student">student</el-option>
        <el-option value="teacher">teacher</el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="学号/职工号" placeholder="请输入学号">
      <el-input v-model="user.id"></el-input>
    </el-form-item>
    <el-form-item label="姓名" placeholder="请输入姓名">
      <el-input v-model="user.name"></el-input>
    </el-form-item>
    <el-form-item label="密码">
      <el-input v-model="user.password" placeholder="密码在6~16位之间 ">
      </el-input>
    </el-form-item>
    <el-form-item label="真实姓名">
      <el-input v-model="user.realName" placeholder="真实姓名"></el-input>
    </el-form-item>
    <el-form-item label="电话">
      <el-input
        v-model="user.phone"
        placeholder="请输入电话号码"
        show-word-limit
        maxlength="11"
      ></el-input>
    </el-form-item>
    <el-form-item label="年龄">
      <el-input v-model="user.age" placeholder="年龄"></el-input>
    </el-form-item>
    <el-form-item label="性别">
      <el-select v-model="user.sex">
        <el-option value="男">男</el-option>
        <el-option value="女">女</el-option>
      </el-select>
    </el-form-item>
        <el-form-item label="地址" placeholder="请输入地址">
      <el-input v-model="user.addr"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submit" v-show="option != 'read'"
        >提交</el-button
      >
      <el-button type="danger" @click="cancel">取消</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
export default {
  data() {
    return {
      user: {
        name: "",
        password: "",
        role: "",
        id: "",
        realName: "",
        phone: "",
        age: "",
        sex: "",
        addr:""
      },
      option: "add",
    };
  },
  methods: {
    submit() {
      if ("add" === this.option) {
        this.registerUser();
      } else if ("edit" === this.option) {
        this.updateUser();
      }
    },
    cancel() {
      this.$router.go(-1);
    },
    registerUser() {
      this.$axios
        .post("/api/register/registerUser", this.user)
        .then((res) => {
          this.$message.success("注册成功");
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("注册失败");
          console.log(err);
        });
    },
    updateUser() {
      this.$axios
        .post("/api/user/updateUser", this.user)
        .then((res) => {
          this.$message.success("角色信息更新成功");
          this.$message.success("注册成功");
          this.$router.go(-1);
        })
        .catch((err) => {
          this.$message.error("角色信息更新失败");
          console.log(err);
        });
    },
    getUserById(id) {
      this.$axios
        .get("/api/user/getUserById?id=" + id)
        .then((res) => {
          this.user = res.data;
        })
        .catch((err) => {
          this.$message.success("读取用户失败");
          console.log(err);
        });
    },
  },
  mounted() {
    this.option = this.$route.params.option;
    if ("read" === this.option) {
      var id = this.$route.params.id;
      this.getUserById(id);
    } else if ("edit" === this.option) {
      id = this.$route.params.id;
      this.getUserById(id);
    } else {
      this.option="add"
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