<template>
  <div class="content">
    <div class="head">
      <el-menu mode="horizontal">
        <span>全部课程</span>
        <el-menu-item v-if='this.user.role==="教师"' style="padding-right:0">
          <el-button type="primary">快速创建活动</el-button>
        </el-menu-item>
        <el-menu-item v-if='this.user.role==="教师"'>
          <el-dropdown trigger="click" @command="handleCommand">
            <el-button type="primary">创建/加入课程</el-button>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item command="创建课程">创建课程</el-dropdown-item>
              <el-dropdown-item command="加入课程">加入课程</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </el-menu-item>
        <el-menu-item v-if='this.user.role==="学生"' style="padding-right:0">
          <el-button type="primary" @click="handleClickAddCourse">加入课程</el-button>
        </el-menu-item>
        <el-menu-item @click="isPlaceOnFileDialogOpen=true">
          <img src="../assets/icon/place_on_file.png" class="menu_icon" />归档管理
        </el-menu-item>
        <el-menu-item @click="isOrderDialogOpen=true">
          <img src="../assets/icon/order.png" class="menu_icon" />课程排序
        </el-menu-item>
      </el-menu>
    </div>
    <course-card v-for="course in courses" :key="course.id" :course="course" @openCreateCourseDialog="editCourse" @refreshData="getUserCourses()"></course-card>
    <!-- 测试数据 -->
    <!-- {{courses}} -->
    <add-course-dialog :visible="isAddCourseDialogOpen" @visibleChanged="ctrlAddCourseDialog" @onDataChanged="getUserCourses()"></add-course-dialog>
    <create-course-dialog :visible="isCreateCourseDialogOpen" :course="createCourseDialogData" :dialogType="createCourseDialogType" @visibleChanged="ctrlCreateCourseDialog"></create-course-dialog>
    <place-on-file-dialog :visible="isPlaceOnFileDialogOpen" @closeDialog="isPlaceOnFileDialogOpen=false;getUserCourses()"></place-on-file-dialog>
    <order-dialog :visible="isOrderDialogOpen" @closeDialog="isOrderDialogOpen=false"></order-dialog>
  </div>
</template>
<script>
import courseCard from "@/components/courseCard";
import addCourseDialog from "@/components/addCourseDialog";
import createCourseDialog from "@/components/createCourseDialog"
import placeOnFileDialog from '@/components/placeOnFileDialog.vue'
import orderDialog from '@/components/orderDialog.vue'
export default {
  components: {
    courseCard,
    addCourseDialog,
    createCourseDialog,
    placeOnFileDialog,
    orderDialog,
  },
  data() {
    return {
      isAddCourseDialogOpen: false,
      isCreateCourseDialogOpen: false,
      createCourseDialogType:"create",//课程编辑页面的类型，create和update
      courses: "",
      createCourseDialogData:"",
      user:'',
      isPlaceOnFileDialogOpen:false,
      isOrderDialogOpen:false,
    };
  },
  methods: {
    handleCommand(command) {
      if ("创建课程" === command) {
        this.createCourseDialogData=this.createNewCourse();
        this.createCourseDialogType='create';
        this.isCreateCourseDialogOpen = true;
      } else if ("加入课程" === command) {
        this.isAddCourseDialogOpen = true;
      }
    },
    editCourse(val){
      this.createCourseDialogData=val
      this.createCourseDialogType='update';
      this.isCreateCourseDialogOpen=true;
    },
    handleClickAddCourse(){
      this.isAddCourseDialogOpen = true;
    },
    ctrlAddCourseDialog(val) {
      this.isAddCourseDialogOpen = val;
    },
    ctrlCreateCourseDialog(val){
      this.isCreateCourseDialogOpen=val;
      this.getUserCourses();
    },
    getUserCourses() {
      this.$axios
        .get("/api/course/getUserCourses")
        .then(res => {
          this.courses = res.data;
        })
        .catch(err => {
          this.$message.error("获取课程失败");
          console.log(err);
        });
    },
    getCurrentUser(){
      this.$axios.get("api/register/getCurrentUser").then(res=>{
        this.user=res.data;
      }).catch(err=>{
        this.$message.error("获取用户信息失败");
      });
    },
    createNewCourse(){
      return {
          name:"",
          className:"",
          schoolYear:"",
          semester:"",
      }
  }
  },
  mounted() {
    this.getUserCourses();
    this.getCurrentUser();
  }
};
</script>

<style scoped>
.head {
  height: 100px;
}
.menu_icon {
  width: 20px;
  height: 20px;
  margin-right: 5px;
}
.el-menu--horizontal > .el-menu-item {
  float: right;
}
span {
  float: left;
}
</style>