<template>
  <el-container>
    <el-header height="60px">用户列表</el-header>
    <el-main>
      <div><el-input class="input" placeholder="请输入用户名字" ></el-input><el-button type="primary" class="button">查询</el-button></div>
      <el-table :data="users" style="width: 100%">
        <el-table-column prop="id" label="ID" width="120">
        </el-table-column>
        <el-table-column prop="name" label="用户名" width="120">
        </el-table-column>
        <el-table-column prop="realName" label="真实姓名" width="120">
        </el-table-column>
        <el-table-column prop="role" label="角色" width="120">
        </el-table-column>
        <el-table-column prop="age" label="年龄" width="120">
        </el-table-column>
        <el-table-column prop="sex" label="性别" width="120"> 
        </el-table-column>
        <el-table-column prop="phone" label="电话" width="220">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="300">
          <template slot-scope="scope">
            <el-button
              @click.native.prevent="readUser(scope.$index)"
              size="medium "
            >
              查看
            </el-button>
             <el-button
              @click.native.prevent="editUser(scope.$index)"
              size="medium "
            >
              编辑
            </el-button>
             <el-button
              @click.native.prevent="delTableUser(scope.$index)"
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
      readUser(index){
        this.jumpToRegisterView("read",this.users[index].id);
      },
      editUser(index){
        this.jumpToRegisterView("edit",this.users[index].id);
      },
      jumpToRegisterView(option,id){
        this.$router.push({ name: "admin_add_register_view",params:{option,id}});//option add,read,edit id:userId
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