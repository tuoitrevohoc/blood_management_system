<template lang="html">
  <li>
    <span>{{user.name}}</span>
    <span class="pull-right">{{distanceOfTimeInWords}}</span>
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

<style lang="css">
</style>
