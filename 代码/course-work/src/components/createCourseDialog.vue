<template>
  <el-dialog :visible.sync="visible" :before-close="closeDialog" width="40%">
    <div slot="title">{{dialogTitle}}</div>
    <div class="body">
      <el-row>
        <el-col :span="4">
          <span class="row_title">课程名称：</span>
        </el-col>
        <el-col :span="20">
          <el-input placeholder="新建课程名称" v-model="tempCourse.name"></el-input>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="4">
          <span class="row_title">班级名称：</span>
        </el-col>
        <el-col :span="20">
          <el-input placeholder="请输入班级名称(选填)" v-model="tempCourse.className"></el-input>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="4">
          <span class="row_title">选择学期：</span>
        </el-col>
        <el-col :span="10">
          <el-select v-model="tempCourse.schoolYear">
            <el-option value="2010-2011" label="2010-2011"></el-option>
            <el-option value="2011-2012" label="2011-2012"></el-option>
            <el-option value="2012-2013" label="2012-2013"></el-option>
            <el-option value="2013-2014" label="2013-2014"></el-option>
            <el-option value="2014-2015" label="2014-2015"></el-option>
            <el-option value="2015-2016" label="2015-2016"></el-option>
            <el-option value="2016-2017" label="2016-2017"></el-option>
            <el-option value="2017-2018" label="2017-2018"></el-option>
            <el-option value="2018-2019" label="2018-2019"></el-option>
            <el-option value="2019-2020" label="2019-2020"></el-option>
          </el-select>
        </el-col>
        <el-col :span="10">
          <el-select v-model="tempCourse.semester">
            <el-option value="0" label="不限"></el-option>
            <el-option value="1" label="第一学期"></el-option>
            <el-option value="2" label="第二学期"></el-option>
          </el-select>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="4">
          <span class="row_title">选择科目：</span>
        </el-col>
        <el-col :span="20">
          <el-select >
            
          </el-select>
        </el-col>
      </el-row>
      <el-row>
        <div class="addition_text">学生必须额外填写下列信息才能加入课程</div>
        <el-checkbox label="自然班级"></el-checkbox>
        <el-checkbox label="年纪"></el-checkbox>
        <el-checkbox label="入学年月"></el-checkbox>
      </el-row>
    </div>
    <div slot="footer">
      <el-button @click="closeDialog" type="info">取消</el-button>
      <el-button @click="submit" type="primary">确定</el-button>
    </div>
  </el-dialog>
</template>
<script>
export default {
  data() {
    return {};
  },
  props: {
    dialogType: {
      required: true
    },
    visible: {
      required: true,
      type: Boolean
    },
    course: {}
  },
  computed: {
    dialogTitle: {
      get() {
        var title = "";
        if ("create" === this.dialogType) {
          title = "新建课程";
        } else if ("update" === this.dialogType) {
          title = "编辑课程";
        }
        return title;
      }
    },
    tempCourse:{
      get(){
        return new Object(this.course);
      }
    }
  },
  methods: {
    closeDialog() {
      this.visibleChanged();
    },
    visibleChanged() {
      this.$emit("visibleChanged", !this.visible);
    },
    createCourse(){
      this.$axios
        .post("api/course/addCourse",this.course)
        .then(res => {
          this.$message({
            message: "创建课程成功",
            type: "success"
          });
          this.closeDialog();
        })
        .catch(err => {
          this.$message({
            message: "创建课程失败",
            type: "error"
          });
        });
    },
    updateCourse(){
      this.$axios
        .post("api/course/updateCourse",this.course)
        .then(res => {
          this.$message({
            message: "更新课程成功",
            type: "success"
          });
          this.closeDialog();
        })
        .catch(err => {
          this.$message({
            message: "更新课程失败",
            type: "error"
          });
        });
    },
    submit() {
      if('create'===this.dialogType){
        this.createCourse();
      }
      else if('update'===this.dialogType){
        this.updateCourse();
      }
    }
  },
};
</script>
<style scoped>
.row_title {
  position: relative;
  top: 10px;
  font-size: 17px;
}
.el-row {
  margin-bottom: 10px;
}
.addition_text {
  font-size: 13px;
  margin-top: 15px;
  margin-bottom: 15px;
}
</style>