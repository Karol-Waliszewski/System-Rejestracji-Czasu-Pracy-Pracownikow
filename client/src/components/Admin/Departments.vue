<template lang="html">
<div>
  <div class="card">
    <header class="card-header">
      <p class="card-header-title">
        Działy
      </p>
      <a href="#" class="card-header-icon" aria-label="more options">
            <span class="icon">
              <i class="fas fa-angle-down" aria-hidden="true"></i>
            </span>
          </a>
    </header>
    <div class="card-content">
      <div class="content">
        <table class="table is-responsive">
          <thead>
            <tr>
              <th>ID</th>
              <th>Nazwa</th>
              <th>Edytuj</th>
              <th>Usuń</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="department in departments">
              <td>{{department.dzial_id}}</td>
              <td>{{department.nazwa}}</td>
              <td>
                <router-link type="button" class="button is-info" :to="'depts/edit/' + department.dzial_id"> <fai icon="user-edit"/> </router-link>
              </td>
              <td>
                <button type="button" class="button is-danger" @click="deleteDept(department.dzial_id)"> <fai icon="user-times"/> </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <div class="notification" :class="{'is-success':alert.success, 'is-danger':!alert.success}" v-if="alert.message">
    {{alert.message}}
  </div>
</div>
</template>

<script>
import FontAwesomeIcon from '@fortawesome/vue-fontawesome'

export default {
  name: 'Departments',
  data() {
    return {
      alert: {},
      departments: []
    }
  },
  components: {
    fai: FontAwesomeIcon
  },
  methods: {
    getDepts() {
      this.$http.get(this.globalURL + '/api/depts')
        .then(res => {
          if (res.status == 200) {
            this.departments = res.body;
          } else {
            this.alert = {
              success: false,
              message: 'Nie udało się pobrać działów z serwera'
            };
          }
        })
        .catch(err => {
          this.alert = {
            success: false,
            message: 'Nie można połączyć się z bazą danych.'
          };
        });
    },
    deleteDept(id) {
      this.$http.delete(this.globalURL + '/api/depts/' + id)
        .then(res => {
          if (res.status == 409) {
            this.alert = {
              success: false,
              message: 'Nie można usunąć działu, z istniejącymi stanowiskami.'
            };
          } else if (res.status != 200) {
            this.alert = {
              success: false,
              message: 'Błąd podczas usuwania działu.'
            };
          } else {
            this.getDepts();
          }
        })
        .catch(err => {
          if (res.status == 409) {
            this.alert = {
              success: false,
              message: 'Nie można usunąć działu, z istniejącymi stanowiskami.'
            };
          } else {
            this.alert = {
              success: false,
              message: 'Nie można połączyć się z bazą danych.'
            };
          }
        });
    }
  },
  mounted() {
    this.getDepts();
  }
}
</script>

<style lang="css">
</style>
