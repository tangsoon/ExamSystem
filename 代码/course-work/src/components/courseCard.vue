<template>
  <div>
    <el-card v-if="course" class="course_card" :body-style="{padding:0}">
      <div class="card_head">
        <router-link
          :to="{path:'/course_page',query:{courseId:course.id,userType:course.userType}}"
          tag="el-link"
          class="course_name"
        >{{course.name}}</router-link>
        <div class="class_name">{{course.className}}</div>
        <div class="join_course_code">
          <img src="../assets/icon/qr.png" class="card_icon" />
          <span>
            加课码：{{course.joinCode}}
            <i class="el-icon-arrow-down el-icon--right"></i>
          </span>
        </div>
        <div class="role_tag">
          <span>{{getRoleTag}}</span>
        </div>
        <div class="semester_tag">
          {{course.schoolYear}}
          <br />
          {{semesterZh}}
        </div>
      </div>
      <div class="card_body">
        <div class="card_body_title">近期作业</div>
        <div
          @click="handleClickWork(exploreWork.id)"
          class="course_work_item"
          v-for="exploreWork in computedWorks"
          :key="exploreWork.id"
        >{{exploreWork.name}}</div>
      </div>
      <div class="card_foot">
        <img src="../assets/jpg/head.jpg" class="face_icon" />
        <div class="foot_member">成员{{course.memberCount}}人</div>
        <el-dropdown trigger="click" @command="handleMore" class="foot_more">
          <div class="foot_more">
            更多
            <img src="../assets/icon/v_point.png" class="foot_icon" />
          </div>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item v-if="course.userType===2||course.userType===1" command="编辑">编辑</el-dropdown-item>
            <el-dropdown-item v-if="course.userType===2" command="删除">删除</el-dropdown-item>
            <el-dropdown-item v-if="course.userType===0" command="退课">退课</el-dropdown-item>
            <el-dropdown-item command="归档">归档</el-dropdown-item>
            <el-dropdown-item v-if="course.userType===2||course.userType===1" command="复制课程">复制课程</el-dropdown-item>
            <el-dropdown-item v-if="course.userType===2||course.userType===1" command="打包下载">打包下载</el-dropdown-item>
            <el-dropdown-item v-if="course.userType===2||course.userType===1" command="转让">转让</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
        <div class="foot_top">置顶</div>
      </div>
    </el-card>
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
    handleClickWork(id) {
      if (0 === this.course.userType) {
        this.jumpToSubmitWorkPage(id);
      } else if (1 === this.course.userType || 2 === this.course.userType) {
        this.jumpToSubmitWorkList(id);
      }
    },
    jumpToSubmitWorkList(id) {
      this.$router.push({
        path: "/submit_work_list",
        query: {id,userType:this.course.userType }
      });
    },
    jumpToSubmitWorkPage(id) {
      this.$router.push({
        path: "/submit_work_page",
        query: { id,userType:this.course.userType }
      });
    },
    openEditCourse() {
      this.$emit("openCreateCourseDialog", this.course);
    },
    delCourse() {
      this.$axios
        .get("api/course/delCourse", { params: { id: this.course.id } })
        .then(res => {
          this.$message.success("删除课程成功");
          this.refreshData();
        })
        .catch(err => {
          this.$message.error("删除课程失败");
        });
    },
    quitCourse() {
      this.$axios
        .get("api/course/quitCourse", { params: { courseId: this.course.id } })
        .then(res => {
          this.$message.success("退出课程成功");
          this.refreshData();
        })
        .catch(err => {
          this.$message.error("退出课程失败");
        });
    },
    placeCourseOnFile() {
      this.$axios
        .get("api/course/placeCourseOnFile", { params: { courseId: this.course.id } })
        .then(res => {
          this.$message.success("归档课程成功");
          this.refreshData();
        })
        .catch(err => {
          this.$message.error("归档课程失败");
        });
    },
    refreshData(){
      this.$emit("refreshData");
    },
    handleMore(command) {
      if ("编辑" === command) {
        this.openEditCourse();
      } else if ("删除" === command) {
        this.delCourse();
      } else if ("退课" === command) {
        this.quitCourse();
      } else if ("归档" === command) {
        this.placeCourseOnFile();
      } else if ("复制课程" === command) {
        this.$message.success("复制课程成功");
      } else if ("打包下载" === command) {
        this.$message.success("打包下载课程成功");
      } else if ("转让" === command) {
        this.$message.success("转让课程成功");
      }
    }
  },
  computed: {
    getRoleTag: {
      get() {
        var roleTag = "";
        if (this.course != null) {
          if (this.course.userType == 0) {
            roleTag = "学";
          } else if (this.course.userType == 1) {
            roleTag = "教";
          } else if (this.course.userType == 2) {
            roleTag = "教";
          }
          return roleTag;
        }
      }
    },
    semesterZh: {
      get() {
        var temp;
        if (this.course != null) {
          if (this.course.semester == 0) {
            temp = "学期不限";
          } else if (this.course.semester == 1) {
            temp = "第一学期";
          } else if (this.course.semester == 2) {
            temp = "第二学期";
          }
          return temp;
        }
      }
    },
    computedWorks: {
      get() {
        var tempList = new Array();
        for (var i = 0; i < 3 && i < this.course.exploreWorks.length; i++) {
          tempList.push(this.course.exploreWorks[i]);
        }
        return tempList;
      }
    }
  },
  mounted() {}
};
</script>
<style scoped>
.course_card {
  width: 270px;
  padding: 0;
  float: left;
  margin-right: 10px;
}
.card_head {
  background-image: url("../assets/img/course_card_img0.png");
  padding: 11px 10px;
  height: 105px;
}
.card_body {
  padding: 11px 10px;
  height: 105px;
}
.card_foot {
  padding: 11px 10px;
  height: 20px;
  border-top: 1px solid #dbdbdb;
  padding: 5px 10px;
}
.course_name {
  color: white;
  font-size: 20px;
}
.class_name {
  color: white;
  font-size: 15px;
  margin-top: 10px;
}
.join_course_code {
  margin-top: 25px;
  background-color: rgb(255, 255, 255, 0.1);
  width: 150px;
}
.join_course_code:hover {
  cursor: pointer;
}
.join_course_code > img {
  width: 20px;
  height: 20px;
}
.join_course_code > span {
  font-size: 12px;
  color: white;
  position: relative;
  top: -5px;
}
.role_tag {
  background-image: url("../assets/icon/book_mark.png");
  width: 18px;
  height: 32px;
  position: relative;
  top: -118px;
  left: 210px;
  padding: 0px 8px;
}
.role_tag > span {
  font-size: 15px;
  color: blue;
}
.semester_tag {
  font-size: 10px;
  position: relative;
  left: 190px;
  top: -80px;
  color: white;
}
.card_body_title {
  font-size: 12px;
}
.course_work_item {
  font-size: 15px;
  padding: 10px 20px;
}
.course_work_item:hover {
  cursor: pointer;
  color: blue;
}
.card_icon {
  width: 20px;
  height: 20px;
  margin-right: 5px;
}
.face_icon {
  width: 20px;
  height: 20px;
  border-radius: 15px;
  float: left;
}
.foot_member {
  font-size: 12px;
  margin-top: 3px;
  margin-left: 10px;
  float: left;
}
.foot_top {
  float: right;
  margin-top: 3px;
  font-size: 12px;
  margin-right: 10px;
}
.foot_top:hover {
  cursor: pointer;
}
.foot_more {
  float: right;
  margin-top: 2px;
  font-size: 12px;
  color: rgb(18, 159, 219);
}
.foot_more:hover {
  cursor: pointer;
}
.foot_icon {
  width: 13px;
  height: 13px;
}
</style>