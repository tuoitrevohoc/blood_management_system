<template lang="html">
  <li class="user-list-grid">
    <img :src="user.avatar.small.url" :alt="user.name" class="small-avatar float-left pdr-small">
    <div class="list-text">
      <a :href="`/users/${user.id}`">{{user.name}}</a>
      <span class="pull-right time-stamp">{{distanceOfTimeInWords}}</span>
    </div>
  </li>
</template>

<script>
export default {
  props: ['user'],
  computed: {
    distanceOfTimeInWords: function() {
      return moment(this.user.was_donating_at).fromNow()
    }
  }
}
</script>

<style scoped>
::-webkit-scrollbar {
  display: none;
}
</style>
