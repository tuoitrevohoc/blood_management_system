import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import store from './store/index'
import Master from './components/master.vue'
import VueAnimateNumber from 'vue-animate-number'
import vueMoment from 'vue-moment'
import Vuebar from 'vuebar'
import VCalendar from 'v-calendar'

import 'v-calendar/lib/v-calendar.min.css'

Vue.use(Vuebar)
Vue.use(VueAnimateNumber)
Vue.use(vueMoment)
Vue.use(VCalendar, {
  firstDayOfWeek: 2,
  datePickerShowDayPopover: false,
  locale: 'vi'
})

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    data: {
      msg: 'hello there'
    },
    components: { App, Master },
    store
  })
})
