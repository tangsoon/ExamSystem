<template>
  <el-container>
    <el-header class="shadow" height="80px">
      <el-menu
        default-active="this.$route.path"
        router
        mode="horizontal"
        style="height: 80px"
      >
        <!-- <el-menu-item class="menu-item" style="margin-left: 50px">
          <img src="../assets/img/logo.png" class="logo" />
        </el-menu-item> -->
        <el-menu-item index="/main_container/course_list">课堂</el-menu-item>
        <el-menu-item index="/exam_container">考试</el-menu-item>
        <el-menu-item index style="float: right">
          <img src="../assets/jpg/head.jpg" class="head_icon" />
        </el-menu-item>
        <el-menu-item index style="float: right">
          <span @click="logOut()">退出登录</span>
        </el-menu-item>
        <el-menu-item index style="float: right">
          <img src="@/assets/icon/notification.png" class="menu_icon" />
        </el-menu-item>
        <el-menu-item index style="float: right">
          <img src="@/assets/icon/add_person.png" class="menu_icon" />邀请教师
        </el-menu-item>
        <el-menu-item index style="float: right">
          <img src="@/assets/icon/search.png" class="menu_icon" />论文
        </el-menu-item>
      </el-menu>
    </el-header>
    <el-main>
      <router-view></router-view>
    </el-main>
  </el-container>
</template>

<script>
export default {
  data(){
    return{
      user:{}
    }
  },
  methods: {
    logOut() {
      this.$axios
        .post("api/logout", {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
        .then((res) => {
          this.$message("退出账号");
          this.jumpToLogin();
        })
        .catch((err) => {
          this.$message.err("退出账号失败");
        });
    },
    jumpToLogin() {
      this.$router.push({ name: "login_page" });
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
  mounted(){
    this.getCurrentUser();
  }
};
</script>

<style scoped>
.shadow {
  box-shadow: 0 0 5px #000;
}

.el-menu--horizontal > .el-menu-item {
  border-bottom: 4px solid #409eff;
  color: #303133;
  height: 81px;
  line-height: 80px;
  margin-left: 15px;
  margin-right: 15px;
}
.logo {
  width: 96px;
  height: 24px;
}
.menu_icon {
  width: 20px;
  height: 20px;
  margin-right: 5px;
}
.head_icon {
  border-radius: 15px;
  width: 30px;
  height: 30px;
}
.el-header {
  padding: 0;
}
.el-main {
  padding: 40px 4% 40px;
}
</style>