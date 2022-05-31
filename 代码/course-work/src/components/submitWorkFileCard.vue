<template>
  <div class="work_file_card">
    <div class="left">
      <div class="file_name">{{workFile.name}}</div>
      <div class="file_path">{{workFile.path}}</div>
    </div>
    <div class="right">
      <el-dropdown trigger="click" @command="handleMore">
        <img src="../assets/icon/white_point.png" class="point_icon" />
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="删除">删除</el-dropdown-item>
          <el-dropdown-item command="下载">下载</el-dropdown-item>
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
    workFile: {
      required: true
    }
  },
  methods: {
    handleMore(command) {
      if ("删除" == command) {
        this.delFile();
      } else if ("下载" == command) {
        this.downloadFile();
      }
    },
    delFile() {
      this.$axios
        .get("api/file/delSubWorkFile", {
          params: { workFileId: this.workFile.id }
        })
        .then(res => {
          this.refresh();
        })
        .catch(err => {
          this.$message.error("删除文件失败");
        });
    },
    downloadFile() {},
    refresh() {
      this.$emit("refresh");
    }
  }
};
</script>
<style scoped>
.work_file_card {
  width: 260px;
  height: 60px;
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
.file_name {
  color: white;
  font-size: 20px;
}
.file_path {
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