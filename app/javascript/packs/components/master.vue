<template lang="html">
  <div>
    <div class="row">
      <statistics/>
    </div>
    <div class="row">
      <div class="col-md-6 col-sm-12">
        Donation chart
      </div>
      <div class="col-md-3 col-sm-12">
        Blood Group pie chart
      </div>
      <div class="col-md-3 col-sm-12">
        <gender-pie-chart :chart-data="datacollection" :options="pieOptions"/>
      </div>
    </div>
    <div class="row">
      <div class="col-md-4 col-sm-12">
        <new-users/>
      </div>
      <div class="col-md-4 col-sm-12">
        <weekly-list/>
      </div>
      <div class="col-md-4 col-sm-12">
        <top-ten/>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import {mapState} from 'vuex'
import NewUsers from './dashboards/NewUsers.vue'
import WeeklyList from './dashboards/WeeklyList.vue'
import TopTen from './dashboards/TopTen.vue'
import Statistics from './dashboards/Statistics.vue'
import GenderPie from './dashboards/GenderPie.js'

export default {
  components: {
    "new-users": NewUsers,
    "weekly-list": WeeklyList,
    "top-ten": TopTen,
    "statistics": Statistics,
    "gender-pie-chart": GenderPie,
  },
  data() {
    return {
      pieOptions: {responsive: true, maintainAspectRatio: false},
      datacollection: null
    }
  },
  mounted () {
    this.fillData()
  },
  methods: {
    fillData () {
      axios.get('/api/dashboard/genders')
        .then(
          response => {
            this.datacollection = {
              labels: response.data.genders.labels,
              datasets: [
                {
                  backgroundColor: ['#e53935', '#43a047'],
                  data: response.data.genders.values
                }
              ]
            }
          },
          error => console.log(error)
        )
    }
  }
}
</script>

<style lang="scss">
</style>
