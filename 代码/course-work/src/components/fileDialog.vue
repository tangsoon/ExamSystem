<template>
  <div class="file_dialog">
    <el-dialog :visible="visible" @close="closeDialog()" @open="getExploreWorkFiles" width="800px">
      <div slot="title">课程文件</div>
      <div class="content">
        <!-- 展示文件卡片 -->
        <work-file-card v-for="exploreWorkFile in exploreWorkFiles" :exploreWorkFile="exploreWorkFile" :key="exploreWorkFile.id" :userType="userType" @refresh="getExploreWorkFiles()"></work-file-card>
        <!-- 上传作业的组件 -->
        <file-upload-card v-if="userType==1||userType==2" :work="exploreWork" operation="explore" @refresh="getExploreWorkFiles"></file-upload-card>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import workFileCard from "@/components/workFileCard.vue";
import fileUploadCard from '@/components/fileUploadCard.vue';
export default {
  data() {
    return {
      exploreWorkFiles: ""
    };
  },
  components: {
    workFileCard,
    fileUploadCard,
  },
  props: {
    visible: {
      required: true
    },
    userType: {
      required: true
    },
    exploreWork: {
      required: true
    }
  },
  methods: {
    closeDialog() {
      this.$emit("closeDialog");
    },
    getExploreWorkFiles() {
      this.$axios
        .get("api/file/getExploreWorkFiles", {
          params: { exploreWorkId: this.exploreWork.id }
        })
        .then(res => {
          this.exploreWorkFiles = res.data;
        })
        .catch(err => {
          this.$message.error("获取作业文件失败");
        });
    }
  }
};
</script>
<style>
.file_dialog .el-dialog__header {
  padding: 20px 20px 10px;
  border-bottom: 1px solid #dbdbdb;
}
.file_dialog .el-dialog__body {
  padding: 30px 40px;
  color: #606266;
  font-size: 14px;
  word-break: break-all;
  height: 500px;
}
</style>