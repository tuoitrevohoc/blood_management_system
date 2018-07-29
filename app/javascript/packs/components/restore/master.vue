<template lang="html">
  <div>
    <action-menu :showActionsMenu="showActionsMenu" :loaded="loaded" @delete-all="deleteMultiple" @restore-all="restoreMultiple" @search="search"/>
    <div class="row">
      <div class="col-md-12">
        <div class="card card-2">
          <div class="card-content table-responsive">
            <table class="table table-hover">
              <thead>
                <tr>
                  <th>
                    <input type="checkbox" name="select-all" value="all" @change="toggleCheckAll">
                  </th>
                  <th>ID</th>
                  <th>Họ và Tên</th>
                  <th>Facebook</th>
                  <th>Email</th>
                  <th>Lý do xoá</th>
                  <th>Thời gian xoá</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="user in users" :key="user.id">
                  <td>
                    <input type="checkbox" name="select-all" :value="user.id" @change="count" class="check-user">
                  </td>
                  <td>{{ user.id }}</td>
                  <td>
                    <a href="javascript:void(0)" @click="showUserProfile(user)" v-text="user.name.trim()"/>
                  </td>
                  <td>{{ user.facebook_account }}</td>
                  <td>{{ user.email }}</td>
                  <td>{{ user.reason_for_deleting }}</td>
                  <td>{{ user.deleted_at }}</td>
                </tr>
              </tbody>
            </table>
            <pagination v-if="users_pagination.total_pages > 1" id="users-pagination"
              :total="usersTotalCount"
              :page-size="usersPageSize"
              :callback="fetchUsers"
              :options="{previousText: 'Trước', nextText: 'Tiếp'}">
            </pagination>
          </div>
        </div>
      </div>
    </div>
    <modal
      name="hello-world"
      :resizable="true"
      :draggable="true">
      hello, world!
    </modal>
  </div>
</template>

<script>
import UserProfile from './UserProfile'
import ActionMenu from './ActionMenu'
import axios from 'axios'

export default {
  data () {
    return {
      showActionsMenu: false,
      users: [],
      users_pagination: {},
      loaded: null
    }
  },
  components: {
    UserProfile,
    ActionMenu
  },
  computed: {
    usersTotalCount: function () {
      return this.users_pagination.total_count || 0
    },

    usersPageSize: function () {
      return this.users_pagination.limit_value || 0
    }
  },
  mounted () {
    this.fetchUsers()
  },
  methods: {
    fetchUsers (page = 1, query) {
      let params = {page}
      if (query && query.trim()) {
        params.q = {name_or_email_or_id_cont: query}
      }
      axios.get('/api/restore/users/', {params}).then(
        response => {
          this.users = response.data.users
          this.users_pagination = response.data.meta
          this.loaded = new Date().getTime()
        },
        error => {
          alert(error)
          this.loaded = new Date().getTime()
        }
      )
    },

    search (query) {
      this.fetchUsers(1, query)
    },

    showUserProfile (user) {
      axios.get(`/api/restore/histories/${user.id}`).then(
        response => {
          const histories = response.data
          this.$modal.show(UserProfile, {user, histories}, {
            resizable: true,
            width: '80%',
            height: 'auto',
            scrollable: true
          })
        },
        error => alert(error)
      )
    },

    toggleCheckAll (e) {
      Array.prototype.forEach.call(document.getElementsByClassName('check-user'),
        checkbox => { checkbox.checked = e.target.checked }
      )
      this.count()
    },

    count () {
      const noChecked = document.querySelectorAll('.check-user:checked').length < 1
      if (noChecked) {
        this.showActionsMenu = false
        return
      }
      this.showActionsMenu = true
    },

    deleteMultiple () {
      console.log('deleteMultiple')
    },

    restoreMultiple () {
      console.log('restoreMultiple')
    }
  }
}
</script>

<style lang="scss">
#users-pagination {
  display: flex;
  .pagination {
    margin: 20px auto;
  }
  .pagination li:not(.active) a {
    background: transparent;
  }
  .pagination li:not(.active) a:hover,
  .pagination li:not(.active) a:focus {
    background: #e2e2e2;
  }
}
</style>
