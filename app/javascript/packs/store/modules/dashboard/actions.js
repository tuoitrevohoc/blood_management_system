import axios from 'axios'
import * as mutations from './mutation-types'

export const fetchStatistics = (context) => {
  axios.get('/api/dashboard/statistics')
    .then(
      response => context.commit(mutations.STATISTICS_FETCHED, response.data.statistics),
      error => console.log(error)
    )
}

export const fetchGenders = (context) => {
  axios.get('/api/dashboard/genders')
    .then(
      response => context.commit(mutations.GENDERS_FETCHED, response.data.genders),
      error => console.log(error)
    )
}

export default {
  fetchStatistics,
  fetchGenders
}
