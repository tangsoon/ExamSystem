<template>
  <div class="place_on_file_dialog">
    <el-dialog :visible="visible" :before-close="closeDialog" @open="getPlacedCourseByUserId()" width="800px">
      <div slot="title">归档管理</div>
      <div class="content">
          <placed-course-card v-for="placedCourse in placedCourses" :key="placedCourse.id" :course="placedCourse" @refresh="getPlacedCourseByUserId();"></placed-course-card>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import placedCourseCard from '@/components/placedCourseCard.vue'
export default {
    components:{
        placedCourseCard,
    },
    data(){
        return {
            placedCourses:"",
        }
    },
    props:{
        visible:{
            required:true,
        }
    },
    methods:{
        closeDialog(){
            this.$emit("closeDialog");
        },
        getPlacedCourseByUserId(){
            this.$axios.get("api/course/getPlacedCourseByUserId")
            .then(res=>{
                this.placedCourses=res.data;
            }).catch(err=>{
                this.$message.error("获取归档课程失败");
            });
        }
    },
};
</script>
<style>
.place_on_file_dialog .el-dialog__header {
  padding: 20px 20px 10px;
  border-bottom: 1px solid #dbdbdb;
}
.place_on_file_dialog .el-dialog__body {
    padding: 30px 40px;
    color: #606266;
    font-size: 14px;
    word-break: break-all;
    height:500px;
}
</style>