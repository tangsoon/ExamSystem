<template>
  <div>作业列表</div>
</template>
<script>
export default {
  data() {
    return {};
  },
  methods: {
    getSubmitWorksByExploreWorkId() {}
  },
  mounted() {
    this.userType = this.$route.query.userType;
    this.exploreWorkId = this.$route.query.id;
    this.getSubmitWorksByExploreWorkId();
  }
};
</script>
<style scoped>
</style>