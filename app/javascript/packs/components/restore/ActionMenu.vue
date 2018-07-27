<template lang="html">
  <div class="row filter-row-2">
    <div class="col-md-12">
      <div v-if="showActionsMenu" class="menu-wrapper">
        <button type="button" class="button-trans" @mouseover="onHover" @mouseleave="onLeave">
          <i class="material-icons">
            more_vert
          </i>
        </button>
        <div :class="{menu: true, active: activeMenu}" id="menu-actions" @mouseover="onHover" @mouseleave="onLeave">
          <ul class="menu-items">
            <li>
              <a href="javascript:void(0)" @click="restoreAll">
                <i class="material-icons">restore</i> Khôi phục
              </a>
            </li>
            <li>
              <a href="javascript:void(0)" @click="deleteAll">
                <i class="material-icons">delete_forever</i> Xoá
              </a>
            </li>
          </ul>
        </div>
      </div>
      <form class="navbar-form header-form navbar-right filter-form-customize" data-remote="true"
        accept-charset="UTF-8" method="get" @submit.prevent="search">
        <a class="btn-clear-search" href="javascript:void(0)" v-show="keyword.trim()" @click="clearSearch">
          <i class="fa fa-close"></i>
        </a>
        <div class="form-group is-empty">
          <input class="form-control search-key" placeholder="Tìm kiếm..." title="Tìm kiếm theo tên, email hoặc ID"
            type="search" @input="search" v-model="keyword">
          <span class="material-input"></span>
        </div>
        <button type="submit" class="btn btn-white btn-round btn-just-icon">
          <i :class="['fa', isLoading ? 'fa-circle-o-notch fa-spin' : 'fa-search']"/>
          <div class="ripple-container"></div>
        </button>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  props: ['showActionsMenu', 'loaded'],
  data () {
    return {
      hoverTimeoutId: null,
      typingTimeoutId: null,
      activeMenu: false,
      keyword: '',
      isLoading: false
    }
  },
  methods: {
    clearSearch () {
      this.keyword = ''
      this.search('')
    },

    search (query) {
      this.isLoading = true
      clearTimeout(this.typingTimeoutId)
      const keyword = typeof query === 'string' ? query : this.keyword.trim()
      const timeout = typeof query === 'string' ? 0 : 1000
      this.typingTimeoutId = setTimeout(() => this.$emit('search', keyword), timeout)
    },

    onHover () {
      clearTimeout(this.hoverTimeoutId)
      this.activeMenu = true
    },

    onLeave () {
      this.hoverTimeoutId = setTimeout(() => { this.activeMenu = false }, 500)
    },

    restoreAll () {
      this.activeMenu = false
      if (confirm('Xác nhận khôi phục lại các tài khoản đã chọn.\nBạn chắc chắn chứ?')) {
        this.$emit('restore-all')
      }
    },

    deleteAll () {
      this.activeMenu = false
      if (confirm('Các tài khoản đã chọn sẽ bị xoá vĩnh viễn.\nBạn chắc chắn chứ?')) {
        this.$emit('delete-all')
      }
    }
  },
  watch: {
    loaded: function () {
      this.isLoading = false
    }
  }
}
</script>

<style scoped lang="scss">
.button-trans {
  display: flex;
  padding: 10px 5px;
  background: transparent;
  border: none;
  margin-left: 15px;
}
.menu-wrapper {
  position: relative;
  float: left;
  min-width: 200px;

  .menu.active {
    display: inline-block;
    width: auto;
    height: auto;
  }

  .menu {
    background: #f7f7f7;
    display: none;
    width: 0;
    height: 0;
    padding: 2px;
    position: absolute;
    top: 5px;
    left: 45px;
    z-index: 2;
    border: 1px solid #e2e2e2;

    li {
      padding: 2px 10px;
    }

    li:hover {
      cursor: pointer;
      background-color: #e2e2e2;
    }
  }
}
</style>
