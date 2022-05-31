<template>
  <div class="work_card">
    <div class="explore_time">
      <div class="time_tag person_work_tag">个人作业</div>
      <div class="time_tag">{{$moment(exploreWork.exploreTime).format('YYYY/MM/DD')}}</div>
      <div class="time_tag">{{$moment(exploreWork.exploreTime).format('HH:mm')}}</div>
    </div>
    <div class="work_name">{{exploreWork.name}}</div>
    <div class="work_content">{{exploreWork.content}}</div>
    <div class="end_time">
      <div class="end_time_tag">
        <span>截止日期：</span>
        {{$moment(exploreWork.exploreTime).format('YYYY/MM/DD')}} {{$moment(exploreWork.exploreTime).format('HH:mm')}}
        <span
          class="discuss"
        >0条讨论</span>
      </div>
    </div>
    <div class="work_card_menu">
      <el-dropdown trigger="click" @command="handleCommand">
        <img src="../assets/icon/point.png" />
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item v-if="userType==1||userType==2" command="edit">编辑</el-dropdown-item>
          <el-dropdown-item  command="课程文件">课程文件</el-dropdown-item>
          <el-dropdown-item v-if="userType==1||userType==2" command="save">保存到备课区</el-dropdown-item>
          <el-dropdown-item v-if="userType==1||userType==2" command="del">删除</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
    <div class="work_card_counter">
      <div class="counter_item">
        <div class="count">0</div>
        <div class="counter_label">已批</div>
      </div>
      <div class="counter_item">
        <div class="count">0</div>
        <div class="counter_label">未批</div>
      </div>
      <div class="counter_item">
        <div class="count">0</div>
        <div class="counter_label">未交</div>
      </div>
    </div>
    <div></div>
  </div>
</template>
<script>
export default {
  props: {
    exploreWork: {
      required: true
    },
    userType: {
      required: true
    }
  },
  methods: {
    handleCommand(command) {
      if ("edit" === command) {
        this.$emit("edit");
      } else if ("save" === command) {
        this.$message.success("保存到备课区");
      } else if ("del" === command) {
        this.delWork();
      }
      else if("课程文件"===command){
        this.openFileDialog();
      }
    },
    openFileDialog(){
      this.$emit("openFileDialog",this.exploreWork);
    },
    delWork() {
      this.$axios
        .get("api/exploreWork/delExploreWork", {
          params: { exploreWorkId: this.exploreWork.id }
        })
        .then(res => {
          this.$message.success("成功删除作业");
          this.refresh();
        })
        .catch(err => {
          this.$message.error("删除作业失败");
        });
    },
    refresh() {
      this.$emit("refresh");
    }
  }
};
</script>
<style scoped>
.work_card {
  width: auto;
  border-radius: 5px;
  border: 1px solid #e2e6ed;
  padding: 15px 15px;
  margin-top: 20px;
  margin-bottom: 20px;
}
.explore_time {
  font-size: 15px;
  height: 30px;
}
.person_work_tag {
  background-color: #f1f3f4;
}
.explore_time .time_tag {
  margin-right: 20px;
  float: left;
  padding: 3px 5px;
}
.work_name {
  font-size: 20px;
  padding: 20px 0px;
}
.work_content {
  font-size: 14px;
  font-weight: 100;
  padding: 5px 0px;
}
.end_time {
  padding: 5px 0;
  font-size: 14px;
  font-weight: 100;
}
.discuss {
  margin-left: 20px;
}
.work_card_menu {
  position: relative;
  top: -160px;
  float: right;
}
.work_card_menu img {
  width: 20px;
  height: 20px;
}
.work_card_counter {
  position: relative;
  top: -80px;
  left: 50px;
  float: right;
}
.counter_item {
  float: left;
  margin-right: 80px;
}
.count {
  font-size: 40px;
  font-weight: 100;
}
.counter_label {
  font-size: 15px;
}
</style>