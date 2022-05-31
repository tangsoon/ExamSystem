<template>
  <el-container style="height: 100%; border: 1px solid #eee">
    <el-aside style="background-color: #545c64">
      <el-menu
        default-active="this.$route.path"
        router
        background-color="#545c64"
        text-color="#fff"
        active-text-color="#ffd04b"
      >
        <el-menu-item index="/main_container/student_container/student_index">主页</el-menu-item>
        <el-submenu index="1">
          <template slot="title"
            ><i class="el-icon-phone"></i>考试</template
          >
          <el-menu-item-group>
            <el-menu-item index="/main_container/student_container/sign_exam"
              >考试报名</el-menu-item
            >
            <el-menu-item index="/main_container/student_container/join_exam"
              >参加考试</el-menu-item
            >
            
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="2">
          <template slot="title"><i class="el-icon-rank"></i>刷题练习</template>
          <el-menu-item-group>
            <el-menu-item index="/main_container/student_container/exam_exercise"
              >生成试卷</el-menu-item
            >
            <el-menu-item index="/main_container/student_container/exercise_list"
              >试卷列表</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
      </el-menu>
    </el-aside>
    <el-main>
      <router-view></router-view>
    </el-main>
  </el-container>
</template>
<script>
export default {};
</script>
<style>
.el-main[data-v-53e1fd77] {
    padding: 0;
}
.el-container{
  height:100%;
}
</style>

