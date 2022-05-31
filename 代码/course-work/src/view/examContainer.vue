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
        <el-menu-item index="/exam_container/exam_index">主页</el-menu-item>
        <el-submenu index="1" v-if="user.role === '管理员'">
          <template slot="title"
            ><i class="el-icon-phone"></i>用户管理</template
          >
          <el-menu-item-group>
            <el-menu-item index="/exam_container/user_list"
              >用户列表</el-menu-item
            >
            <el-menu-item index="/exam_container/user_add/register_view"
              >添加用户</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-submenu
          index="2"
          v-if="user.role === '教师' || user.role == '管理员'"
        >
          <template slot="title"><i class="el-icon-rank"></i>学科管理</template>
          <el-menu-item-group>
            <el-menu-item index="/exam_container/subject_list"
              >学科列表</el-menu-item
            >
            <el-menu-item index="/exam_container/subject_details"
              >学科创编</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-submenu
          index="3"
          v-if="user.role === '教师' || user.role == '管理员'"
        >
          <template slot="title"
            ><i class="el-icon-edit-outline"></i>题库管理</template
          >
          <el-menu-item-group>
            <el-menu-item index="/exam_container/question_list"
              >题目列表</el-menu-item
            >
            <el-menu-item index="/exam_container/question_single_choice_edit"
              >单选题创编</el-menu-item
            >
            <el-menu-item index="/exam_container/question_multiple_choice_edit"
              >多选题创编</el-menu-item
            >
            <el-menu-item index="/exam_container/quesiton_true_false_edit"
              >判断题创编</el-menu-item
            >
            <el-menu-item index="/exam_container/quesiton_filling_edit"
              >填空题创编</el-menu-item
            >
            <el-menu-item index="/exam_container/questin_short_answer_edit"
              >简答题创编</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-submenu
          index="4"
          v-if="user.role === '教师' || user.role == '管理员'"
        >
          <template slot="title"
            ><i class="el-icon-document"></i>试卷管理</template
          >
          <el-menu-item-group>
            <el-menu-item index="/exam_container/paper_list"
              >试卷列表</el-menu-item
            >
            <el-menu-item index="/exam_container/paper_details"
              >试卷创编</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-submenu
          index="5"
          v-if="user.role === '教师' || user.role == '管理员'"
        >
          <template slot="title"><i class="el-icon-edit"></i>考试管理</template>
          <el-menu-item-group>
            <el-menu-item index="/exam_container/exam_list"
              >考试列表</el-menu-item
            >
            <el-menu-item index="/exam_container/exam_details"
              >考试编辑</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="6" v-if="user.role == '管理员'">
          <template slot="title"><i class="el-icon-date"></i>日志管理</template>
          <el-menu-item-group>
            <el-menu-item index="/exam_container/log_list">查看日志</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="7" v-if="user.role == '管理员'">
          <template slot="title"><i class="el-icon-s-grid"></i>数据统计</template>
          <el-menu-item index="/exam_container/statistics">查看统计</el-menu-item>
        </el-submenu>
        <el-submenu index="8" v-if="user.role == '学生'">
          <template slot="title"
            ><i class="el-icon-tickets"></i>考试列表</template
          >
          <el-menu-item-group>
            <el-menu-item index="/exam_container/join_exam"
              >我的考试</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="9" v-if="user.role == '学生'">
          <template slot="title"><i class="el-icon-edit"></i>在线刷题</template>
          <el-menu-item-group>
            <el-menu-item index="/exam_container/paper_list"
              >智能训练</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="10" v-if="user.role == '学生'">
          <template slot="title"
            ><i class="el-icon-star-off"></i>我的收藏</template
          >
          <el-menu-item-group>
            <el-menu-item index="/exam_container/question_list"
              >题目收藏</el-menu-item
            >
          </el-menu-item-group>
        </el-submenu>
        <el-menu-item index="/main_container"> 返回课堂 </el-menu-item>
      </el-menu>
    </el-aside>
    <el-main>
      <router-view></router-view>
    </el-main>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      user: {},
    };
  },
  methods: {
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
  mounted() {
    this.getCurrentUser();
  },
};
</script>
<style scoped>
</style>