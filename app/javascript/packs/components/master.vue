<template>
  <div>
    <div class="row">
      <statistics/>
    </div>
    <div class="row">
      <div class="col-md-6 col-sm-12 line-chart">
        <h4>
          Biểu đồ lượt hiến máu trong tuần
          <span class="pull-right group-control-2">
            <datepicker ref="programaticOpen" input-class="weekly-date"
              wrapper-class="date-picker-wrapper" :language="'vi'"
              @selected="redrawWeeklyChart" :format="'D, d MMMM'"
              :placeholder="formatedDate" :monday-first="true"
            />
            <i class="material-icons pull-right date-picker" @click="openPicker">event</i>
          </span>
        </h4>
        <weekly :chart-data="weeklyData" :options="lineOptions" class="line-chart-wrapper"/>
      </div>
      <div class="col-md-3 col-sm-6 pie-chart">
        <h4>Sơ đồ Tỷ lệ nhóm máu</h4>
        <blood-types-chart :chart-data="bloodTypeData" :options="pieOptions" class="pie-chart-wrapper"/>
      </div>
      <div class="col-md-3 col-sm-6 pie-chart">
        <h4>Sơ đồ tỷ lệ giới tính</h4>
        <gender-pie-chart :chart-data="datacollection" :options="pieOptions" class="pie-chart-wrapper"/>
      </div>
    </div>
    <div class="row">
      <top-users/>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import {mapState} from 'vuex'
import Statistics from './dashboards/Statistics.vue'
import GenderPie from './dashboards/GenderPie.js'
import BloodTypesPie from './dashboards/BloodTypesPie.js'
import TopUsers from './dashboards/TopUsers.vue'
import Weekly from './dashboards/Weekly.js'
import Datepicker from 'vuejs-datepicker'

export default {
  components: {
    "statistics": Statistics,
    "gender-pie-chart": GenderPie,
    "blood-types-chart": BloodTypesPie,
    "top-users": TopUsers,
    Weekly,
    Datepicker
  },
  data() {
    return {
      datacollection: null,
      bloodTypeData: null,
      weeklyData: null,
      date: moment(),
      pieOptions: {
        responsive: true,
        maintainAspectRatio: false,
        legend: false,
      },
      lineOptions: {
        responsive: true,
        maintainAspectRatio: false,
        legend: false,
        scales: {
          yAxes: [{
             ticks: {
                stepSize: 1
             }
          }]
        },
      },
    }
  },
  mounted () {
    this.fillGenderData()
    this.fillBloodTypeData()
    this.fetchWeeklyData(this.date)
  },
  computed: {
    formatedDate: function() {
      return this.date.format('dddd, d MMMM')
    }
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
    },
    fetchWeeklyData (date) {
      axios.get('/api/dashboard/weekly', {params: {date: date}})
        .then(
          response => {
            this.weeklyData = {
              labels: Object.keys(response.data.weekly_data),
              datasets: [
                {
                  label: 'Số lượt hiến',
                  borderColor: '#9c27b0',
                  pointBackgroundColor: 'white',
                  borderWidth: 1,
                  pointBorderColor: 'white',
                  backgroundColor: this.gradient,
                  data: Object.values(response.data.weekly_data)
                }
              ]
            }
          },
          error => console.log(error)
        )
    },
    openPicker () {
      this.$refs.programaticOpen.showCalendar()
    },
    redrawWeeklyChart (date) {
      this.fetchWeeklyData(moment(date))
    }
  }
}
</script>

<style lang="scss">
  .pie-chart {
    .pie-chart-wrapper {
      height: 250px;
    }
  }

  .line-chart {
    .line-chart-wrapper {
      height: 300px;
    }
  }

  .group-control-2 {
    display: flex;

    .weekly-date {
      width: auto;
      font-size: 12px;
      height: 28px;
      border: 1px solid #3c4857;
      background-color: rgba(255, 255, 255, .5);
      padding-left: 10px;
    }

    .date-picker {
      margin-top: 5px;
      background-color: #3c4857;
      height: 28px;
      color: #fff;
      font-weight: normal;
      padding-top: 3px;
    }

    .date-picker:hover {
      cursor: pointer;
    }
  }

  .date-picker-wrapper {
    .next, .prev {
      display: inline-block !important;
    }
  }
</style>
