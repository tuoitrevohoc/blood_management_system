import * as mutations from './mutation-types'

export default {
  [mutations.STATISTICS_FETCHED] (state, statistics) {
    state.statistics = statistics
  },

  [mutations.GENDERS_FETCHED] (state, genderPie) {
    state.genderPieData.labels = genderPie.labels
    state.genderPieData.datasets.data = genderPie.values
  },

  [mutations.TOP_USERS_FETCHED] (state, payload) {
    state.newUsers = payload.new_users
    state.recentDonors = payload.recent_donors
    state.topDonors = payload.top_donors
    state.top_value = payload.top_value
  }
}
