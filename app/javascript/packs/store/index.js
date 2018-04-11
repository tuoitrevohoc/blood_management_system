import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex/dist/vuex.esm'
import dashboard from './modules/dashboard'

Vue.use(Vuex)

export default new Vuex.Store({
  strict: true,
  modules: {
    dashboard
  }
})
