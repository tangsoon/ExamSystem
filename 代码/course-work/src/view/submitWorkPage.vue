<template>
  <div class="submit_work_page">
    <div class="title">
      <h4>{{exploreWork.name}}</h4>
    </div>
    <div class="content">
      <submit-work-file-card v-for="workFile in computedWorkFiles" :key="workFile.id" :workFile="workFile" @refresh="getSubmitWork()">
      </submit-work-file-card>
        <file-upload-card :work="exploreWork" operation="submit" :submitWorkId="submitWork.id" @refresh="getSubmitWork()"></file-upload-card>
    </div>
    <div class="foot">
      <el-button type="danger">返回</el-button>
    </div>
  </div>
</template>
<script>
import submitWorkFileCard from "@/components/submitWorkFileCard.vue";
import fileUploadCard from '@/components/fileUploadCard.vue'
export default {
  data() {
    return {
      userType: -1,
      exploreWorkId: "",
      exploreWork: "",
      submitWork: ""
    };
  },
  components: {
    submitWorkFileCard,
    fileUploadCard
  },
  methods: {
    getExploreWork() {
      this.$axios
        .get("api/exploreWork/getExploreWorkById", {
          params: { exploreWorkId:this.exploreWorkId }
        })
        .then(res => {
          this.exploreWork = res.data;
        })
        .catch(err => {
          this.$message.error("获取ExploreWork失败");
        });
    },
    getSubmitWork(){
        this.$axios
        .get("api/submitWork/getSubmitWork", {
          params: { exploreWorkId:this.exploreWorkId }
        })
        .then(res => {
          this.submitWork = res.data;
        })
        .catch(err => {
          this.$message.error("获取SubmitWork失败");
        });
    }
  },
  computed:{
      computedWorkFiles:{
          get(){
              if(this.submitWork.workFiles!=null){
                  return this.submitWork.workFiles
              }
          }
      }
  },
  mounted() {
    this.userType = this.$route.query.userType;
    this.exploreWorkId = this.$route.query.id;
    this.getExploreWork();
    this.getSubmitWork();
  }
};
</script>
<style scoped>
.submit_work_page {
  padding: 5% 15%;
}
.content{
    padding: 20px 20px;
}
</style>