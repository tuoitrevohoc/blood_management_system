<template lang="html">
  <div>
    <div class="col-md-3 col-sm-6">
      <div class="card card-stats">
        <div class="card-header" data-background-color="green">
          <i class="material-icons">group</i>
        </div>
        <div class="card-content">
          <p class="category">Tổng thành viên</p>
          <h3 class="title">
            <animated-number :value="statistics.total_users" :formatValue="toFixNum" :duration="duration"/>
          </h3>
        </div>
      </div>
    </div>
    <div class="col-md-3 col-sm-6">
      <div class="card card-stats">
        <div class="card-header" data-background-color="orange">
          <i class="material-icons">hotel</i>
        </div>
        <div class="card-content">
          <p class="category">Tổng bệnh nhân</p>
          <h3 class="title">
            <animated-number :value="statistics.total_patients" :formatValue="toFixNum" :duration="duration"/>
          </h3>
        </div>
      </div>
    </div>
    <div class="col-md-3 col-sm-6">
      <div class="card card-stats">
        <div class="card-header" data-background-color="red">
          <i class="material-icons">local_hospital</i>
        </div>
        <div class="card-content">
          <p class="category">Tổng lượt hiến</p>
          <h3 class="title">
            <animated-number :value="statistics.total_histories" :formatValue="toFixNum" :duration="duration"/>
          </h3>
        </div>
      </div>
    </div>
    <div class="col-md-3 col-sm-6">
      <div class="card card-stats">
        <div class="card-header" data-background-color="blue">
          <i class="material-icons">invert_colors</i>
        </div>
        <div class="card-content">
          <p class="category">Có thể hiến máu</p>
          <h3 class="title">
            <animated-number :value="statistics.can_donate" :formatValue="toFixNum" :duration="duration"/>
          </h3>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapActions, mapState} from 'vuex'
import AnimatedNumber from "animated-number-vue"

export default {
  data () {
    return {
      duration: 750
    }
  },
  components: {
    AnimatedNumber
  },
  computed: {
    ...mapState('dashboard', [
      'statistics'
    ])
  },
  created() {
    this.fetchStatistics()
  },
  methods: {
    ...mapActions('dashboard', [
      'fetchStatistics'
    ]),

    toFixNum (val) {
      return Math.round(val)
    }
  }
}
</script>

<style lang="css">
</style>
