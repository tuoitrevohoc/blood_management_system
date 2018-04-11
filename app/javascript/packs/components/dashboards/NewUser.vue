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
      return moment(this.user.created_at).fromNow()
    }
  }
}
</script>

<style lang="scss">
  .small-avatar {
    height: 24px;
  }

  .float-left {
    float: left;
  }

  .pdr-small {
    margin-right: 5px;
  }

  .user-list-grid {
    margin: 5px 0;

    .list-text {
      height: 24px;
      margin-left: 5px;
    }

    .time-stamp {
      font-size: 13px;
      color: #797979;
    }
  }
  .user-list-grid:hover {
    background-color: rgba(156, 39, 176, 0.1);
  }
</style>
