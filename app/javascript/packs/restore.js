import Vue from 'vue/dist/vue.esm'
import store from './store/index'
import Master from './components/restore/master.vue'
import VModal from 'vue-js-modal'
import Pagination from 'vue-pagination-bootstrap'

import 'v-calendar/lib/v-calendar.min.css'

Vue.use(VModal, {dynamic: true, injectModalsContainer: true})
Vue.component('pagination', Pagination)

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#restore-app',
    components: {Master},
    store
  })
})
