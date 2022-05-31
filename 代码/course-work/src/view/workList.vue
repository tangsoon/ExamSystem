<template>
  <div>
    <div class="work_list_head">
      <el-button v-if="userType==1||userType==2" type="primary" plain @click="openWorkExploreCard('create')">发布个人作业</el-button>
      <el-button v-if="userType==1||userType==2" type="primary" plain>发布小组作业</el-button>
      <div class="download_work_tag">
        <img src="../assets/icon/download.png" class="little_icon" /> 下载所有作业{{this.userType}}
      </div>
    </div>
    <work-explore-card
      v-if="isWorkExploreCardOpen"
      :exploreWork="workExploreCardData"
      @close_card="handleCloseCard();getExploreWorkList()"
      @refresh="getExploreWorkList()"
      :operation="exploreCardOperation"
    ></work-explore-card>
    <work-card
      v-for="exploreWork in exploreWorks"
      :key="exploreWork.id"
      :exploreWork="exploreWork"
      :userType='userType'
      @refresh="getExploreWorkList()"
      @edit="openWorkExploreCard('update',exploreWork)"
      @openFileDialog="openFileDialog(exploreWork)"
    ></work-card>
    <file-dialog :visible="isFileDialogOpen" @closeDialog="isFileDialogOpen=false" :userType="userType" :exploreWork="fileDialogData"></file-dialog>
  </div>
</template>
<script>
import workExploreCard from "@/components/workExploreCard";
import workCard from "@/components/workCard";
import fileDialog from "@/components/fileDialog.vue"
export default {
  components: {
    workExploreCard,
    workCard,
    fileDialog,
  },
  data() {
    return {
      isFileDialogOpen:false,
      //fileDialog当前的数据
      fileDialogData:"",

      isWorkExploreCardOpen: false,
      exploreCardOperation: "",
      courseId: "",
      exploreWorks: "",
      workExploreCardData: this.workFactory(),
      userType:-1,

    };
  },
  methods: {
    openWorkExploreCard(operation, exploreWork) {

      if ("create" === operation) {
        this.workExploreCardData = this.workFactory();
        this.workExploreCardData.courseId=this.courseId;
      } else if ("update" === operation) {
        this.workExploreCardData = exploreWork;
      }
      this.exploreCardOperation=operation;
      this.isWorkExploreCardOpen = true;
    },
    openFileDialog(exploreWork){
      this.fileDialogData=exploreWork;
      this.isFileDialogOpen=true;
    },
    getExploreWorkList() {
      this.$axios
        .get("api/exploreWork/getExploreWorkByCourseId", {
          params: {courseId:this.courseId }
        })
        .then(res => {
          this.exploreWorks = res.data;
        })
        .catch(err => {
          this.$message.error("获取作业失败");
        });
    },
    handleCloseCard() {
      this.isWorkExploreCardOpen = false;
    },
    workFactory() {
      return {
        name: "",
        endTime: "",
        content: "",
        fullScore: ""
      };
    }
  },
  mounted() {
    this.courseId = this.$route.query.courseId;
    this.userType=this.$route.query.userType
    this.getExploreWorkList();
  }
};
</script>
<style scoped>
.work_list_head {
  width: 100%;
  height: 50px;
  margin-top: 30px;
}
.little_icon {
  width: 20px;
  height: 20px;
}
.download_work_tag {
  float: right;
  font-size: 15px;
  color: #1296db;
}
.work_list_card {
  width: 100%;
  border-radius: 5px;
  border: 1px solid #e2e6ed;
  padding: 15px 15px;
  margin-top: 20px;
  margin-bottom: 20px;
}
</style>