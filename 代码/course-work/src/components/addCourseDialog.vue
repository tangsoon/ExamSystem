<template>
  <el-dialog :visible.sync="visible" :before-close="closeDialog" width="20%">
    <span slot="title">加入课程</span>
    <el-input placeholder="请输入课程加课验证码" v-model="joinCourseCode"></el-input>
    <span slot="footer">
      <el-button type="info" @click="closeDialog">取消</el-button>
      <el-button type="primary" @click="submit">加入</el-button>
    </span>
  </el-dialog>
</template>
<script>
export default {
  data() {
    return {
      joinCourseCode: ""
    };
  },
  methods: {
    closeDialog() {
      this.visibleChanged();
    },
    submit() {
      this.$axios
        .get("/api/course/addCourseByJoinCode", {
          params: { joinCode: this.joinCourseCode }
        })
        .then(res => {
          this.$message({ message: "添加课程成功", type: "success" });
          this.onDataChanged();
        })
        .catch(err => {
          this.$message.error("添加课程失败");
          console.log(err);
        });
      this.visibleChanged();
    },
    visibleChanged() {
      this.$emit("visibleChanged", false);
    },
    onDataChanged(){
      this.$emit("onDataChanged");
    }
  },
  props: {
    visible: {
      required: true,
      type: Boolean
    }
  }
};
</script>
<style scoped>

</style>