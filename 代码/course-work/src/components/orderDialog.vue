<template>
  <div class="orderDialog">
    <el-dialog :visible="visible" :before-close="closeDialog" width="800px">
      <div slot="title">课程排序</div>
      <div class="content">这是内容</div>
    </el-dialog>
  </div>
</template>
<script>
export default {
    props:{
        visible:{
            required:true,
        }
    },
    methods:{
        closeDialog(){
            this.$emit("closeDialog");
        },
    }
};
</script>
<style>
.orderDialog .el-dialog__header {
  padding: 20px 20px 10px;
  border-bottom: 1px solid #dbdbdb;
}
</style>