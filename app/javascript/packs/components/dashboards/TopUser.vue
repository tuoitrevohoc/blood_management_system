<template lang="html">
  <li>
    {{user.name}}
    <span class="pull-right">{{user.quantity}} lần</span>
  </li>
</template>

<script>
export default {
  props: ['user']
}
</script>

<style lang="css">
</style>
