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
        <el-menu-item index="/admin_container/admin_index">主页</el-menu-item>
        <el-submenu index="2">
          <template slot="title"><i class="el-icon-rank"></i>学科管理</template>
          <el-menu-item-group>
            <el-menu-item index="/subject_list"
              >学科列表</el-menu-item
            >
            <el-menu-item index="/admin_container/subject_details"
              >学科创编</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="3">
          <template slot="title"
            ><i class="el-icon-edit-outline"></i>题库管理</template
          >
          <el-menu-item-group>
            <el-menu-item index="/admin_container/question_list"
              >题目列表</el-menu-item
            >
            <el-menu-item index="/admin_container/question_single_choice_edit"
              >单选题创编</el-menu-item
            >
            <el-menu-item index="/admin_container/question_multiple_choice_edit"
              >多选题创编</el-menu-item
            >
            <el-menu-item index="/admin_container/quesiton_true_false_edit"
              >判断题创编</el-menu-item
            >
            <el-menu-item index="/admin_container/quesiton_filling_edit"
              >填空题创编</el-menu-item
            >
            <el-menu-item index="/admin_container/questin_short_answer_edit"
              >简答题创编</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="4">
          <template slot="title"
            ><i class="el-icon-document"></i>试卷管理</template
          >
          <el-menu-item-group>
            <el-menu-item index="/admin_container/paper_list"
              >试卷列表</el-menu-item
            >
            <el-menu-item index="/admin_container/paper_details"
              >试卷创编</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="5">
          <template slot="title"><i class="el-icon-edit"></i>考试管理</template>
          <el-menu-item-group>
            <el-menu-item index="/admin_container/admin_exam_list"
              >考试列表</el-menu-item
            >
            <el-menu-item index="/admin_container/exam_edit"
              >考试编辑</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-menu-item index="/main_container/course_list">
        <i class="el-icon-back"></i>
        <span slot="title">返回课堂</span>
      </el-menu-item>
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
<style scoped>
</style>