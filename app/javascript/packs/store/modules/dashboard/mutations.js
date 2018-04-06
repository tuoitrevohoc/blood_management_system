import * as mutations from './mutation-types'

export default {
  [mutations.STATISTICS_FETCHED] (state, statistics) {
    state.statistics = statistics
  },

  [mutations.GENDERS_FETCHED] (state, genderPie) {
    state.genderPieData.labels = genderPie.labels
    state.genderPieData.datasets.data = genderPie.values
  }
}
