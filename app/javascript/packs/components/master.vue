<template>
  <div>
    <div class="row">
      <statistics/>
    </div>
    <div class="row">
      <div class="col-md-6 col-sm-12">
        Donation chart
      </div>
      <div class="col-md-3 col-sm-6 pie-chart">
        <p>Sơ đồ Tỷ lệ nhóm máu</p>
        <blood-types-chart :chart-data="bloodTypeData" :options="pieOptions" class="pie-chart-wrapper"/>
      </div>
      <div class="col-md-3 col-sm-6 pie-chart">
        <p>Sơ đồ tỷ lệ giới tính</p>
        <gender-pie-chart :chart-data="datacollection" :options="pieOptions" class="pie-chart-wrapper"/>
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
import BloodTypesPie from './dashboards/BloodTypesPie.js'

export default {
  components: {
    "new-users": NewUsers,
    "weekly-list": WeeklyList,
    "top-ten": TopTen,
    "statistics": Statistics,
    "gender-pie-chart": GenderPie,
    "blood-types-chart": BloodTypesPie,
  },
  data() {
    return {
      pieOptions: {responsive: true, maintainAspectRatio: false, legend: false, height:250},
      datacollection: null,
      bloodTypeData: null
    }
  },
  mounted () {
    this.fillGenderData()
    this.fillBloodTypeData()
  },
  methods: {
    fillGenderData () {
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
    },
    fillBloodTypeData () {
      axios.get('/api/dashboard/blood_types')
        .then(
          response => {
            this.bloodTypeData = {
              labels: response.data.blood_types.map(group => group.name),
              datasets: [
                {
                  backgroundColor: ['#e63935', '#711b1a', '#00d8ff', '#006577', '#41b882', '#026538', '#fdcd55', '#906700'],
                  data: response.data.blood_types.map(group => group.percentage)
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

<style scoped lang="scss">
  .pie-chart {
    .pie-chart-wrapper {
      height: 250px;
    }
  }
</style>
