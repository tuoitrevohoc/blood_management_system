<template lang="html">
  <div class="modal-wrapper col-md-12">
    <div class="row">
      <div class="col-md-12">
        <h3>Thông tin thành viên</h3>
      </div>
      <div class="col-md-3">
        <div class="avatar">
          <img :src="user.avatar.medium.url" :alt="`Avatar ${user.name}`">
        </div>
      </div>
      <div class="col-md-9">
        <div class="user-info">
          <table class="table table-hover">
            <tr v-for="attribute in Object.keys(dataset)" :key="attribute">
              <th v-text="dataset[attribute]"></th>
              <td v-text="user[attribute] || '-'"></td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="user-histories">
          <h3>Lịch sử hiến máu</h3>
          <table class="table table-hover">
            <thead>
              <tr>
                <th>ID</th>
                <th>Ngày hiến</th>
                <th>Hình thức</th>
                <th>Cơ sở tiếp nhận</th>
                <th>Người tạo</th>
                <th>Ngày tạo</th>
                <th>Thay đổi gần nhất</th>
                <th>Ngày xoá</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="history in histories"  :key="history.id">
                <td v-text="history.id"></td>
                <td v-text="history.date"></td>
                <td v-text="history.donation_type"></td>
                <td>
                  {{history.place.name}}<br>
                  {{history.place.address}}
                </td>
                <td>
                  {{history.admin_name}}
                </td>
                <td v-text="history.created_at"></td>
                <td v-text="history.updated_at"></td>
                <td v-text="history.deleted_at"></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6 col-sm-12">
        <div class="restore-section">
          <h3>Khôi phục tài khoản</h3>
          <p>Đưa tài khoản trở lại trên danh sách</p>
          <button class="btn btn-success" @click="confirmRestore">
            <i class="material-icons">restore</i> Khôi phục lại tài khoản này
          </button>
        </div>
      </div>
      <div class="col-md-6 col-sm-12">
        <div class="restore-section">
          <h3>Xoá Vĩnh viễn</h3>
          <p>Tài khoản này sẽ bị khoá vĩnh viễn khỏi hệ thống.</p>
          <button type="button" class="btn btn-danger" @click="confirmDestroy">
            <i class="material-icons">delete_forever</i> Xoá
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  props: ['user', 'histories'],
  computed: {
    dataset: function () {
      return {
        "id": "Số thứ tự",
        "email": "Email",
        "name": "Họ và tên",
        "facebook_account": "Facebook",
        "gender": "Giới tính",
        "blood_type": "Nhóm máu",
        "id_number": "Số CMND",
        "birthday": "Ngày sinh",
        "phone_number": "Số ĐT",
        "phone_number_2": "Số ĐT 2",
        "address": "Địa chỉ",
        "formatted_address": "Địa chỉ đầy đủ",
        "place_of_birth": "Nguyên quán",
        "description": "Ghi chú",
        "role": "Quyền truy cập",
        "created_at": "Ngày tham gia",
        "updated_at": "Lần thay đổi gần nhất",
        "deleted_at": "Ngày bị xoá",
        "reason_for_deleting": "Lý do bị xoá"
      }
    }
  },
  methods: {
    confirmRestore () {
      if (confirm("Xác nhận khôi phục lại tài khoản này?")) {
        this.restore(this.user)
      }
    },

    confirmDestroy () {
      if (confirm('Xác nhận xoá vĩnh viễn tài khoản này khỏi hệ thống.\nCác lịch sử của thành viên này cũng sẽ bị xoá vĩnh viễn.')) {
        this.really_destroy(this.user)
      }
    },

    restore ({id}) {
      axios.post(`/api/restore/${id}`).then(
        response => this.$emit('restored', this.user),
        error => alert(error)
      )
    },

    really_destroy ({id}) {
      axios.delete(`/api/restore/really_destroy/${id}`).then(
        response => this.$emit('deleted', this.user),
        error => alert(error)
      )
    }
  }
}
</script>

<style scoped lang="scss">
.modal-wrapper {
  margin-top: 20px;
  margin-bottom: 20px;

  .user-info {
    table {
      tr {
        border: 1px solid #efefef;
        th {
          background: #f4f4f4;
          text-align: right;
          margin-right: 20px;
        }
        th, td {
          padding: 5px 10px;
        }
      }
      tr:hover, tr:hover th {
        background: #eee;
      }
    }
  }
  .user-histories {
    table {
      th {
        font-size: 15px;
        font-weight: bold;
      }
      td {
        font-size: 14px;
      }
    }
  }
}
</style>
