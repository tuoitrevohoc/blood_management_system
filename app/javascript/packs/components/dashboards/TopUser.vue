<template lang="html">
  <li class="user-list-grid">
    <img :src="user.avatar.small.url" :alt="user.name" class="small-avatar float-left pdr-small">
    <div class="list-text">
      <a :href="`/users/${user.id}`">{{user.name}}</a>
      <span class="pull-right counting">{{user.quantity}} lần</span>
    </div>
  </li>
</template>

<script>
export default {
  props: ['user']
}
</script>

<style lang="css">
  .counting {
    font-weight: 800;
    font-size: 13px;
    position: absolute;
    right: 0;
    bottom: 0;
  }
</style>
