<template>
  <el-container v-if="course">
    <el-header height="72px" mode="horizontal">
      <img src="../assets/icon/drawer.png" class="head_icon head_item" />
      <el-breadcrumb separator-class="el-icon-arrow-right" class="head_item">
        <el-breadcrumb-item><router-link
          :to="{path:'/main_container/course_list',query:{courseId:course.id,userType:course.userType}}"
          tag="el-link"
        >课堂</router-link></el-breadcrumb-item>
        <el-breadcrumb-item>{{course.name}}</el-breadcrumb-item>
      </el-breadcrumb>
      <span class="head_item" style="margin-top: 20px;">{{course.className}}</span>
      <img class="head_jpg head_right_item" src="../assets/jpg/head.jpg" />
      <img src="../assets/icon/notification.png" class="head_icon head_right_item" />
    </el-header>
    <el-main>
      <div class="course_card" style="padding:0px">
        <div class="course_card_head">
          <div>
            <span class="course_name">{{course.name}}</span>
            <img src="../assets/icon/edit.png" class="head_icon" />
          </div>
          <div class="class_name">
            <span>{{course.className}}</span>
          </div>
          <div class="card_tag_div">
            <div class="card_tag">
              <img src="../assets/icon/qr.png" class="card_tag_icon" />
              <div class="card_tag_font">加课二维码</div>
            </div>
            <div class="card_tag">
              <div class="card_tag_font">
                加课码：{{course.joinCode}}
                <i class="el-icon-arrow-down el-icon--right"></i>
              </div>
            </div>
            <div class="card_tag">
              <img src="../assets/icon/member.png" class="card_tag_icon" />
              <div class="card_tag_font">成员 {{course.memberCount}}</div>
            </div>
            <div class="card_tag">
              <img src="../assets/icon/statistics.png" class="card_tag_icon" />
              <div class="card_tag_font">数据分析</div>
            </div>
            <div class="card_tag">
              <img src="../assets/icon/grade.png" class="card_tag_icon" />
              <div class="card_tag_font">成绩</div>
            </div>
          </div>
          <div class="set_skin_tag">
            <img src="../assets/icon/skin.png" /> 更改背景
          </div>
          <div v-if="course.userType===1||course.userType===2" class="counter_view">
            <div class="counter">
              <div class="count">0</div>
              <div class="counter_name">互动个数</div>
            </div>
            <div class="counter">
              <div class="count">0</div>
              <div class="counter_name">发布作业</div>
            </div>
            <div class="counter">
              <div class="count">0</div>
              <div class="counter_name">发布测试</div>
            </div>
          </div>
        </div>
        <div class="course_card_foot">
          <div class="menu_item" @click="handleMenuItemClick('/course_page/course_interaction')">课堂互动</div>
          <div class="menu_item" @click="handleMenuItemClick('/course_page/course_work')">作业</div>
          <div class="menu_item" @click="handleMenuItemClick('/course_page/course_topic')">话题</div>
          <div class="menu_item" @click="handleMenuItemClick('/course_page/course_data')">资料</div>
          <div class="menu_item" @click="handleMenuItemClick('/course_page/course_test')">考试</div>
          <div class="menu_item" @click="handleMenuItemClick('/course_page/course_notice')">公告</div>
        </div>
      </div>
      <div>
        <router-view></router-view>
      </div>
    </el-main>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      course: ""
    };
  },
  methods: {
    handleMenuItemClick(routerPath) {
      this.$router.push({path:routerPath,query:{courseId:this.course.id,userType:this.course.userType}});
    },
    getCourseById(val) {
      
      this.$axios
        .get("api/course/getCourseById",{params:{courseId:val}})
        .then(res => {
          this.course=res.data;
        })
        .catch(err => {
          this.$message.error("获取课程失败");
        });
    }
  },
  mounted() {
    var courseId = this.$route.query.courseId;
    this.getCourseById(courseId);
  }
};
</script>
<style scoped>
.el-header {
  padding: 0 40px;
}
.el-main {
  padding: 40px 150px;
}
.head_item {
  margin-top: 25px;
  margin-right: 30px;
  float: left;
  font-size: 15px;
}
.head_icon {
  width: 20px;
  height: 20px;
}
.head_jpg {
  border-radius: 15px;
  width: 30px;
  height: 30px;
}
.head_right_item {
  float: right;
  margin-left: 50px;
  margin-top: 20px;
}

.course_card {
  width: 100%;
  border-radius: 5px;
  border: 1px solid #e2e6ed;
  padding: 15px 15px;
  margin-top: 20px;
  margin-bottom: 20px;
}
.course_card_head {
  border-radius: 5px;
  height: 150px;
  padding-top: 50px;
  padding-left: 40px;
  padding-right: 40px;
  background-image: url("../assets/img/course_big_background.jpg");
  color: white;
  background-repeat: no-repeat no-repeat;
  background-size: 100% 100%;
}
.course_card_foot {
  height: 72px;
  padding-left: 60px;
}
.course_name {
  margin-right: 20px;
  font-size: 30px;
}
.class_name {
  font-size: 20px;
  margin-top: 10px;
}
.card_tag_div {
  height: 24px;
  padding: 25px 0px;
}
.card_tag {
  height: 16px;
  padding: 3px 3px;
  background: rgb(255, 255, 255, 0.4);
  font-size: 10px;
  float: left;
  margin-right: 10px;
  border-radius: 2px;
}
.card_tag:hover {
  cursor: pointer;
}
.card_tag_font {
  float: left;
  margin-top: 2px;
}
.card_tag_icon {
  width: 16px;
  height: 16px;
  float: left;
  margin-right: 5px;
}
.set_skin_tag {
  font-size: 16px;
  position: relative;
  top: -190px;
  left: 20px;
  float: right;
}
.set_skin_tag img {
  width: 20px;
  height: 20px;
  position: relative;
  top: 2px;
}
.counter_view {
  position: relative;
  left: 110px;
  top: -100px;
  float: right;
}
.counter {
  float: left;
  margin-right: 45px;
  position: relative;
}
.count {
  font-size: 45px;
  margin-left: 8px;
}
.counter_name {
  font-size: 12px;
}
.menu_item {
  font-size: 16px;
  float: left;
  height: 20px;
  padding: 26px 30px;
}
.menu_item:hover {
  color: #1296db;
  cursor: pointer;
}
</style>
