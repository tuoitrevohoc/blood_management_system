<template>
  <div>
    <div class="row">
      <statistics/>
    </div>
    <div class="row">
      <div class="col-md-6 col-sm-12 line-chart">
        <h4>
          Biểu đồ lượt hiến máu
          <span class="pull-right group-control-2">
            <v-date-picker class="date-picker-wrapper" mode="range" v-model="selectedDate"
              :theme-styles="themeStyles" :formats="{input: ['DD/MM/YYYY']}" :attributes="attributes">
            </v-date-picker>
            <i class="material-icons pull-right date-picker">event</i>
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
      <div class="col-md-6 col-sm-12 bar-chart">
        <h4>Biểu đồ số thành viên mới hằng tháng</h4>
        <users-monthly :chart-data="userMonthlyData" :options="barOptions" :height="300" class="bar-chart-wrapper"></users-monthly>
      </div>
      <div class="col-md-6 col-sm-12 bar-chart">
        <h4>Biểu đồ số lượt hiến hằng tháng</h4>
        <histories-monthly :chart-data="historyMonthlyData" :options="barOptions" :height="300" class="bar-chart-wrapper"></histories-monthly>
      </div>
    </div>
    <div class="row">
      <top-users/>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import moment from 'moment'
import {mapState} from 'vuex'
import Statistics from './dashboards/Statistics.vue'
import GenderPie from './dashboards/GenderPie.js'
import BloodTypesPie from './dashboards/BloodTypesPie.js'
import TopUsers from './dashboards/TopUsers.vue'
import Weekly from './dashboards/Weekly.js'
import UsersMonthly from './dashboards/UsersMonthly.js'
import HistoriesMonthly from './dashboards/HistoriesMonthly.js'

export default {
  components: {
    'statistics': Statistics,
    'gender-pie-chart': GenderPie,
    'blood-types-chart': BloodTypesPie,
    'top-users': TopUsers,
    Weekly,
    UsersMonthly,
    HistoriesMonthly
  },
  data () {
    const start = moment().startOf('isoWeek')
    return {
      attributes: [{
        bar: {
          backgroundColor: '#ff8080',
          borderColor: '#ff6666',
          borderWidth: '2px',
          borderStyle: 'solid'
        },
        dates: [new Date()]
      }],
      themeStyles: {
        header: {
          fontSize: '1.4rem'
        },
        weekdays: {
          fontSize: '1.4rem'
        },
        dayContent: {
          fontSize: '1.4rem'
        }
      },
      selectedDate: {
        start: start.toDate(),
        end: moment(start).add(6, 'days').toDate()
      },
      datacollection: null,
      bloodTypeData: null,
      weeklyData: null,
      date: moment(),
      pieOptions: {
        responsive: true,
        maintainAspectRatio: false,
        legend: false
      },
      lineOptions: {
        responsive: true,
        maintainAspectRatio: false,
        legend: false,
        scales: {
          yAxes: [{
            ticks: {
              // stepSize: 1
            }
          }]
        }
      },
      barOptions: {
        responsive: true,
        maintainAspectRatio: false,
        legend: false
      },
      userMonthlyData: null,
      historyMonthlyData: null
    }
  },
  mounted () {
    this.fillGenderData()
    this.fillBloodTypeData()
    this.fetchWeeklyData(Object.values(this.selectedDate))
    this.fetchMonthlyData()
  },
  computed: {
    formatedDate: function () {
      return this.date.format('dddd, d MMMM')
    },
    startDate: function () {
      return this.selectedDate.start
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
    fetchWeeklyData (dates) {
      axios.get('/api/dashboard/weekly', {params: {dates}})
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
    fetchMonthlyData () {
      const collection = {user: 'Số thành viên mới', history: 'Số lượt hiến'}
      Object.keys(collection).forEach(type => {
        const params = {type: type}
        axios.get('/api/dashboard/monthly', {params})
          .then(
            response => {
              this[`${type}MonthlyData`] = {
                labels: response.data.monthly_data.map(m => m.month_year),
                datasets: [
                  {
                    label: collection[type],
                    borderWidth: 1,
                    backgroundColor: this.gradient,
                    hoverBackgroundColor: '#bbb',
                    data: response.data.monthly_data.map(m => m.total)
                  }
                ]
              }
            },
            error => console.log(error)
          )
      })
    }
  },
  watch: {
    startDate: function (start) {
      let end = new Date(start)
      end.setDate(start.getDate() + 6)
      this.selectedDate.end = end
      this.fetchWeeklyData(Object.values(this.selectedDate))
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

  // .bar-chart {
  //   .bar-chart-wrapper {
  //     height: 300px;
  //   }
  // }

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
      position: relative;
    }

    .time-stamp {
      font-size: 13px;
      color: #797979;
      position: absolute;
      right: 0;
      bottom: 0;
    }
  }
  .user-list-grid:hover {
    background-color: rgba(156, 39, 176, 0.1);
  }

  .date-picker-wrapper {
    input {
      font-size: 1.4rem;
      padding-left: 5px;
      padding-right: 7px;
      height: 30px;
      margin-top: 4px;
      width: 170px;
    }
    .c-day-layer {
      .c-day-background {
        margin-bottom: 8px;
      }
      .c-day-bars {
        margin-bottom: 5px;
      }
    }
  }
</style>
