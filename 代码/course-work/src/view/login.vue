<template>
  <div class="back"><el-form
    ref="user"
    :model="user"
    label-width="80px"
    class="lalala"
  >
  <h1>用户登录</h1>
    <el-form-item label="用户名">
      <el-input v-model="user.username" style="width: 240px"></el-input>
    </el-form-item>
    <el-form-item label="密码">
      <el-input
        type="password"
        v-model="user.password"
        style="width: 240px"
      ></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submit">提交</el-button>
      <el-button type="primary" @click="jumpToRegisterView">注册</el-button>
    </el-form-item>
  </el-form></div>
</template>
<script>
import qs from "qs";
export default {
  data() {
    return {
      type: "",
      user: {},
      username: "",
      password: "",
    };
  },
  methods: {
    submit() {
      this.login();
    },
    jumpToRegisterView() {
      this.$router.push({ name: "register_view" });
    },
    login() {
      this.$axios
        .post("api/login", qs.stringify(this.user), {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
        .then((res) => {
          this.$message("登录成功");
          this.jumpToList();
        })
        .catch((err) => {
          //  alert(err.response.data);
          //  console.log(err);
          alert("登录失败");
        });
    },
    jumpToList() {
      this.$router.push({ name: "main_container" });
    },
  },
};
</script>
<style scoped>
.back{
  width: 100%;
    height: 100%;
    background-image: url('background.jpg');
    background-repeat: no-repeat;
    background-size: cover;
}
.lalala{
      width: 36%;
    margin: 0px auto;
    background-color: rgba(110, 132,214,0.1);
    padding: 13px;
    border-radius: 10px;
    color: white;
    position: relative;
    top: 20%;
}
</style>