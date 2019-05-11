<template lang="html">
<div>
  <div class="card">
    <header class="card-header">
      <p class="card-header-title">
        Stanowiska
      </p>

    </header>
    <div class="card-content">
      <div class="content">
        <table class="table is-responsive">
          <thead>
            <tr>
              <th>ID</th>
              <th>Nazwa</th>
              <th>Godziny pracy</th>
              <th>Stawka godzinowa</th>
              <th>Dział</th>
              <th>Edytuj</th>
              <th>Usuń</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="job in jobs">
              <td>{{job.stanowisko_id}}</td>
              <td>{{job.nazwa_stanowiska}}</td>
              <td>{{job.godz_rozpoczecia_naliczania_oplaty.slice(0,5)}} - {{job.godz_zakonczenia_naliczania_oplaty.slice(0,5)}}</td>
              <td>{{job.stawka_godz}}</td>
              <td>{{job.nazwa}}</td>
              <td>
                <router-link type="button" class="button is-info" :to="'jobs/edit/' + job.stanowisko_id"> <fai icon="user-edit"/> </router-link>
              </td>
              <td>
                <button type="button" class="button is-danger" @click="deleteJob(job.stanowisko_id)"> <fai icon="user-times"/> </button>
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
  name: 'Jobs',
  data() {
    return {
      alert: {},
      jobs: []
    }
  },
  components: {
    fai: FontAwesomeIcon
  },
  methods: {
    getJobs() {
      this.$http.get(this.globalURL + '/api/jobs')
        .then(res => {
          if (res.status == 200) {
            this.jobs = res.body;
          } else {
            this.alert = {
              success: false,
              message: 'Nie udało się pobrać stanowisk z serwera'
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
    deleteJob(id) {
      this.$http.delete(this.globalURL + '/api/jobs/' + id)
        .then(res => {
          if (res.status != 200) {
            this.alert = {
              success: false,
              message: 'Błąd podczas usuwania stanowska.'
            };
          } else {
            this.getJobs();
          }
        })
        .catch(err => {
          if (err.status == 409) {
            this.alert = {
              success: false,
              message: 'Nie można usunąć stanowiska, do którego przypisani są pracownicy'
            }
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
    this.getJobs();
  }
}
</script>

<style lang="css">
</style>
