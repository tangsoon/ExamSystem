<template>
  <el-container>
    <el-header height="60px">添加用户</el-header>
    <el-main>
      <router-view ></router-view>
    </el-main>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      users:[]
    };
  },
  methods:{
      getAllUsers(){
          this.$axios
        .get("/api/user/getAllUsers")
        .then(res => {
          this.users = res.data;
        })
        .catch(err => {
          this.$message.error("获取所有用户失败");
          console.log(err);
        });
      },
      delTableUser(index){
          this.delUser(this.users[index].id);
          this.getAllUsers();
      },
      delUser(id){
           this.$axios
        .get("/api/user/delUserById?id="+id)
        .then(res => {
          this.$message.success("删除用户成功");
        })
        .catch(err => {
          this.$message.error("删除用户失败");
          console.log(err);
        });
      }
  },
  mounted() {
    this.getAllUsers();
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
.button{
    margin: 0 10px;
}

</style>