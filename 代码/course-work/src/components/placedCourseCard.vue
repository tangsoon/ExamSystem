<template>
  <div class="place_course_card">
    <div class="left">
      <div class="course_name">{{course.name}}</div>
      <div class="user_type">{{course.userType===0?"学生":"教师"}}</div>
    </div>
    <div class="right">
      <el-dropdown trigger="click" @command="handleMore">
        <img src="../assets/icon/white_point.png" class="point_icon" />
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="恢复">恢复</el-dropdown-item>
          <el-dropdown-item command="删除">删除</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {};
  },
  props: {
    course: {
      required: true
    }
  },
  methods: {
    resumeCourseFromFile() {
        this.$axios.get("api/course/resumeCourseFromFile",{params:{courseId:this.course.id}}).then(res=>{
            this.$message.success("恢复课程成功");
            this.refresh();
        }).catch(err=>{
            this.$message.error("恢复课程失败");
        });
    },
    delCourse() {
        this.$axios.get("api/course/delCourse",{params:{id:this.course.id}}).then(res=>{
            this.$message.success("删除课程成功");
            this.refresh();
        }).catch(err=>{
            this.$message.error("删除课程失败");
        });
    },
    quitCourse(){
        this.$axios.get("api/course/quitCourse",{params:{courseId:this.course.id}}).then(res=>{
            this.$message.success("删除课程成功");
            this.refresh();
        }).catch(err=>{
            this.$message.error("删除课程失败");
        });
    },
    refresh(){
        this.$emit("refresh");
    },
    handleMore(command) {
      if ("恢复" === command) {
          this.resumeCourseFromFile();
      } 
      else if ("删除" === command) {
          if(0===this.course.userType){
              this.quitCourse();
          }
          else if(1===this.course.userType){
              this.quitCourse();
          }
          else if(2===this.course.userType){
              this.delCourse();
          }
      }
    }
  }
};
</script>
<style scoped>
.place_course_card {
  width: 260px;
  height: 60px;
  float: left;
  background-image: url(/static/img/course_card_img0.d7be144.png);
  padding: 20px 20px;
  background-size: 100%;
  margin: 20px 30px;
}
.left {
  width: 90%;
  height: 100%;
  float: left;
}
.course_name {
  color: white;
  font-size: 20px;
}
.user_type {
  color: white;
  font-size: 15px;
  margin-top: 10px;
}
.right {
  width: 10%;
  height: 100%;
  float: right;
}
.point_icon {
  width: 30px;
  height: 30px;
}
</style>