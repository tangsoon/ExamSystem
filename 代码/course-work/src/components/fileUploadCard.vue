<template>
  <div class="file_upload_card">
    <el-upload
      :action="operation==='explore'?'api/file/uploadExpWorkFile':'api/file/uploadSubWorkFile'"
      :show-file-list="false"
      :on-success="onSuccess"
      :before-upload="beforeUpload"
    >
      <img src="../assets/icon/upload.png" class="upload_icon" />
    </el-upload>
  </div>
</template>
<script>
export default {
  data() {
    return {};
  },
  props: {
    work: {
      required: true
    },
    submitWorkId:{
      required:false
    },
    // 发布作业时的文件为"explore",提交作业时值为"submit"
    operation: {
      required: true
    }
  },
  methods: {
    addExploreWorkFile(response, file) {
      var workFileId = response[0];
      this.$axios
        .get("api/file/uploadExploreWorkFile", {
          params: {
            exploreWorkId: this.work.id,
            workFileId: parseInt(workFileId)
          }
        })
        .then(res => {
          this.$message.success("文件上传成功");
          this.refresh();
        })
        .catch(err => {
          this.$message.error("文件上传失败");
        });
    },
    addSubmitWorkFile(response, file) {
      var workFileId = response[0];
      this.$axios
        .get("api/file/uploadSubmitWorkFile", {
          params: {
            submitWorkId: this.submitWorkId,
            workFileId: parseInt(workFileId)
          }
        })
        .then(res => {
          this.$message.success("文件上传成功");
          this.refresh();
        })
        .catch(err => {
          this.$message.error("文件上传失败");
        });
    },
    onSuccess(response, file) {
      if ("explore" === this.operation) {
        this.addExploreWorkFile(response, file);
      } else if ("submit" === this.operation) {
        this.addSubmitWorkFile(response, file);
      }
      else{
        alert("无效的operation");
      }
    },
    refresh() {
      this.$emit("refresh");
    },
    beforeUpload(file) {
      this.fileName = file.name;
    }
  }
};
</script>
<style scoped>
.file_upload_card {
  width: 260px;
  height: 60px;
  padding: 20px 20px;
  margin: 20px 30px;
  background-size: 100%;
}
.upload_icon {
  width: 60px;
  height: 60px;
}
</style>