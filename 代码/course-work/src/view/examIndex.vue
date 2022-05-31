<template>
  <el-container>
    <el-header height="60px"> 欢迎您，{{user.name}}({{user.role}}) </el-header>
    <el-main>欢迎进入智能考试系统</el-main>
  </el-container>
</template>
<script>
export default {
  data(){
    return {
      user:{}
    }
  },  
  methods:{
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
  mounted(){
    this.getCurrentUser();
  }
};
</script>
<style scoped>
.shadow {
  box-shadow: 0 0 2px #000;
}
</style>