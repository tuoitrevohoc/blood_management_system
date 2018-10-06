<template lang="html">
  <div>
    <div class="col-md-4 col-sm-12">
      <h4 title="Thành viên mới trong vòng 30 ngày gần đây">
        Thành viên mới
        <span class="badge badge-danger">{{newUsers.length}}</span>
      </h4>
      <div class="vuebar-element" v-bar>
        <div>
          <ul class="new-users">
            <new-user v-for="user in newUsers" :key="user.id" :user="user"/>
          </ul>
        </div>
      </div>
      <p class="list-description">
        Những thành viên mới trong vòng 30 ngày gần đây.
      </p>
    </div>
    <div class="col-md-4 col-sm-12">
      <h4 title="10 thành viên vừa hiến máu gần đây nhất">
        Thành viên vừa hiến máu
        <span class="badge badge-danger">{{recentDonors.length}}</span>
      </h4>
      <div class="vuebar-element" v-bar>
        <div>
          <ul class="recent-users">
            <recent-user v-for="user in recentDonors" :key="user.id" :user="user"/>
          </ul>
        </div>
      </div>
      <p class="list-description">
        10 thành viên vừa hiến máu gần đây nhất.
      </p>
    </div>
    <div class="col-md-4 col-sm-12">
      <h4 :title="topUserTitle">
        Top thành viên
        <span class="badge badge-danger">{{topDonors.length}}</span>
      </h4>
      <div class="vuebar-element" v-bar>
        <div>
          <ul class="top-users">
            <top-user v-for="user in topDonors" :key="user.id" :user="user"/>
          </ul>
        </div>
      </div>
      <p class="list-description">
        Top thành viên có từ {{top_value}} lần hiến máu trở lên.
      </p>
    </div>
  </div>
</template>

<script>
import NewUser from './NewUser.vue'
import RecentUser from './RecentUser.vue'
import TopUser from './TopUser.vue'
import {mapActions, mapState} from 'vuex'

export default {
  components: {
    "new-user": NewUser,
    "recent-user": RecentUser,
    "top-user": TopUser
  },
  computed: {
    ...mapState('dashboard', [
      'newUsers',
      'recentDonors',
      'topDonors',
      'top_value'
    ]),
    topUserTitle: function() {
      return `Top thành viên có số lượt hiến máu nhiều thứ 3 trong hệ thống (${this.top_value} lần)`
    }
  },
  created() {
    this.fetchTopUsers()
  },
  methods: {
    ...mapActions('dashboard', [
      'fetchTopUsers'
    ])
  }
}
</script>

<style scoped>
::-webkit-scrollbar {
  display: none;
}
</style>

<style lang="scss">
  .badge-danger {
    color: #fff;
    background-color: #dc3545;
    font-weight: 700;
  }

  .list-description {
    font-size: 14px;
    font-style: italic;
  }

  .list-description::before {
    content: '*';
  }

  .vuebar-element {
    height: 250px;
    padding-right: 15px;
  }

  .vb > .vb-dragger {
      z-index: 5;
      width: 12px;
      right: 0;
  }

  .vb > .vb-dragger > .vb-dragger-styler {
      -webkit-backface-visibility: hidden;
      backface-visibility: hidden;
      -webkit-transform: rotate3d(0,0,0,0);
      transform: rotate3d(0,0,0,0);
      -webkit-transition:
          background-color 100ms ease-out,
          margin 100ms ease-out,
          height 100ms ease-out;
      transition:
          background-color 100ms ease-out,
          margin 100ms ease-out,
          height 100ms ease-out;
      background-color: rgba(156, 39, 176, .0);
      margin: 5px 5px 5px 0;
      border-radius: 20px;
      height: calc(100% - 10px);
      display: block;
  }

  .vb.vb-scrolling-phantom > .vb-dragger > .vb-dragger-styler {
      background-color: rgba(156, 39, 176, .3);
  }

  .vb > .vb-dragger:hover > .vb-dragger-styler {
      background-color: rgba(156, 39, 176, .5);
      margin: 0px;
      height: 100%;
  }

  .vb.vb-dragging > .vb-dragger > .vb-dragger-styler {
      background-color: rgba(156, 39, 176, .5);
      margin: 0px;
      height: 100%;
  }

  .vb.vb-dragging-phantom > .vb-dragger > .vb-dragger-styler {
      background-color: rgba(156, 39, 176, .5);
  }

  .new-users,
  .recent-users,
  .top-users {
    background-color: rgba(255, 255, 255, .5);
    padding: 5px;
  }

  .vuebar-element:hover {
    .vb-dragger-styler {
        background-color: rgba(156, 39, 176, .3);
    }
  }
</style>
