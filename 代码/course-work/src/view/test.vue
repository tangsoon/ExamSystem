<template>
  <div>
    <h1>{{ oldName }}</h1>
    <h1>{{ newName }}</h1>
    <el-input v-model="oldName"></el-input>
    <el-input v-model="newName"></el-input>
  </div>
</template>
<script>
export default {
   data() {
    return {
      oldName:"张三"
    };
  },
  computed:{
      newName:{
          get(){
              return this.oldName;
          },
          set(newValue){
             // this.oldName=newData;
              alert("hehe");
          }
      }
  }
};
</script>
<style scoped>
</style>