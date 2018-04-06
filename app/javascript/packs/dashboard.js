import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import store from './store/index'
import Master from './components/master.vue'
import VueAnimateNumber from 'vue-animate-number'

Vue.use(VueAnimateNumber)

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
