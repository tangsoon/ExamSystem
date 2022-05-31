<template>
  <div class="work_explore_card">
    <el-input placeholder="作业名称" v-model="exploreWork.name" class="card_item"></el-input>
    <el-input
      placeholder="请输入作业内容"
      :rows="3"
      type="textarea"
      v-model="exploreWork.content"
      class="card_item"
    ></el-input>
    <el-row class="card_item font_15">
      <el-col :span="2" class="card_item_label">截止时间：</el-col>
      <el-col :span="22">
        <el-date-picker v-model="exploreWork.endTime" type="datetime" placeholder="选择日期时间"></el-date-picker>
      </el-col>
    </el-row>
    <el-row class="card_item font_15">
      <el-col :span="2" class="card_item_label">满分值：</el-col>
      <el-col :span="2">
        <el-input
          v-model="exploreWork.fullScore"
          onkeyup="value=value.replace(/[^\d]/g,'')"
          maxlength="3"
          placeholder="满分"
        ></el-input>
      </el-col>
    </el-row>
    <div class="foot">
      <el-button
        type="primary"
        class="foot_button"
        @click="submit()"
      >{{operation==='create'?'发布个人作业':'保存'}}</el-button>
      <el-button type="primary" class="foot_button" plain @click="closeCard()">取消</el-button>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    exploreWork: {},
    operation: {}
  },
  data() {
    return {};
  },
  methods: {
    submit() {
      if (this.exploreWork.name === "" || this.exploreWork.content === "") {
        this.$message.error("作业的名字和内容不能为空");
        return;
      }
      if (this.operation === "create") {
        this.createExploreWork();
      } else if (this.operation === "update") {
        this.updateExploreWork();
      }
    },
    createExploreWork() {
      this.$axios
        .post("api/exploreWork/addExploreWork", this.exploreWork)
        .then(res => {
          this.closeCard();
        })
        .catch(err => {
          this.$message.error("发布作业失败");
        });
    },
    updateExploreWork() {
      this.$axios
        .post("api/exploreWork/updateExploreWork", this.exploreWork)
        .then(res => {
          this.closeCard();
        })
        .catch(err => {
          this.$message.error("编辑作业失败");
        });
    },
    refresh(){
      this.$emit("refresh");
    },
    closeCard() {
      this.$emit("close_card");
    }
  }
};
</script>
<style scoped>
.work_explore_card {
  width: auto;
  border-radius: 5px;
  border: 1px solid #e2e6ed;
  padding: 15px 15px;
  margin-top: 20px;
  margin-bottom: 20px;
}
.card_item {
  margin-top: 10px;
  margin-bottom: 10px;
}
.font_15 {
  font-size: 15px;
}
.card_item_label {
  position: relative;
  top: 10px;
}
.foot {
  height: 40px;
  width: auto;
  padding: 10px 0px;
}
.foot_button {
  float: right;
  margin-left: 30px;
}
</style>