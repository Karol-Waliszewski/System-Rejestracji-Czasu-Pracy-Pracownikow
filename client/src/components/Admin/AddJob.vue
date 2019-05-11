<template>
<div>
  <div class="card">
    <header class="card-header">
      <p class="card-header-title">
        Dodaj Stanowisko
      </p>
    </header>
    <div class="card-content">
      <form class="content">
        <div class="field">
          <label class="label" for="nazwa_stanowiska">Nazwa</label>
          <div class="control">
            <input id="nazwa_stanowiska" class="input" :class="{'is-danger' : errors.nazwa_stanowiska}" type="text" placeholder="Podaj nazwę..." v-model="job.nazwa_stanowiska">
          </div>
          <p v-if="errors.nazwa_stanowiska" class="help is-danger">
            {{errors.nazwa_stanowiska}}
          </p>
        </div>

        <div class="field">
          <label class="label">Dział</label>
          <div class="select" :class="{'is-danger' : errors.dzial_id}">
            <select v-model="job.dzial_id">
              <option v-for="dept in departments" :value="dept.dzial_id">{{dept.nazwa}}</option>
          </select>
          </div>
          <p v-if="errors.dzial_id" class="help is-danger">
            {{errors.dzial_id}}
          </p>
        </div>

        <div class="field">
          <label class="label">Godziny Pracy</label>
          <div class="select" :class="{'is-danger' : errors.godz_rozpoczecia_naliczania_oplaty}">
            <datepicker :class="{'is-danger' : errors.godz_rozpoczecia_naliczania_oplaty}" v-model="job.godz_rozpoczecia_naliczania_oplaty" :config="{language, enableTime: true,
              noCalendar: true,
              dateFormat: 'H:i',
              time_24hr: true,
              defaultDate: '08:00',
              //maxDate: job.godz_zakonczenia_naliczania_oplaty
              }">
            </datepicker>
          </div>
          <div class="select" :class="{'is-danger' : errors.godz_rozpoczecia_naliczania_oplaty}">
            <datepicker :class="{'is-danger' : errors.godz_rozpoczecia_naliczania_oplaty}" v-model="job.godz_zakonczenia_naliczania_oplaty" :config="{language, enableTime: true,
              noCalendar: true,
              dateFormat: 'H:i',
              time_24hr: true,
              defaultDate: '20:00',
              //minDate: job.godz_rozpoczecia_naliczania_oplaty
              }">
            </datepicker>
          </div>
          <p v-if="errors.godz_rozpoczecia_naliczania_oplaty" class="help is-danger">
            {{errors.godz_rozpoczecia_naliczania_oplaty}}
          </p>
        </div>

        <label class="label" for="stawka_godz">Stawka</label>
        <div class="field has-addons">
          <div class="control">
            <input id="stawka_godz" class="input" :class="{'is-danger' : errors.stawka_godz}" type="number" placeholder="Podaj stawkę..." v-model="job.stawka_godz">
          </div>
          <div class="control">
            <a class="button is-static">
              zł
            </a>
          </div>
        </div>
        <p v-if="errors.stawka_godz" class="help is-danger block">
          {{errors.stawka_godz}}
        </p>

        <div class="field is-grouped">
          <p class="control">
            <a class="button is-primary" @click="submit">
              Submit
            </a>
          </p>
          <p class="control">
            <a class="button is-light" @click="reset">
              Cancel
            </a>
          </p>
        </div>
      </form>
    </div>
  </div>

  <div class="notification" :class="{'is-success':alert.success, 'is-danger':!alert.success}" v-if="alert.message">
    {{alert.message}}
  </div>

</div>
</template>

<script>
import Datepicker from 'vue-bulma-datepicker'

export default {
  name: 'AddUser',
  data() {
    return {
      job: {
        dzial_id: '',
        nazwa_stanowiska: '',
        godz_rozpoczecia_naliczania_oplaty: '',
        godz_zakonczenia_naliczania_oplaty: '',
        stawka_godz: ''
      },
      errors: {},
      alert: {},
      departments: []
    }
  },
  components: {
    Datepicker
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
    submit(e) {
      e.preventDefault();
      if (this.validate()) {
        if (this.$route.params.id)
          this.updateJob();
        else
          this.addJob();
        this.reset();
      }
    },
    resetErrors() {
      this.errors = {};
      for (let prop in this.job) {
        this.$delete(this.errors, prop);
      };
    },
    validate() {
      var flag = true;
      let {
        job
      } = this;

      this.resetErrors();

      // Validation
      if (job.nazwa_stanowiska.length == 0) {
        flag = false;
        this.$set(this.errors, 'nazwa_stanowiska', 'Proszę podać nazwę.');
      }
      if (job.godz_rozpoczecia_naliczania_oplaty === job.godz_zakonczenia_naliczania_oplaty) {
        flag = false;
        this.$set(this.errors, 'godz_rozpoczecia_naliczania_oplaty', 'Proszę podać poprawne godziny pracy');
      }
      if (job.stawka_godz.length == 0) {
        flag = false;
        this.$set(this.errors, 'stawka_godz', 'Proszę podać stawkę za godzinę.');
      }
      if (job.dzial_id.length == 0) {
        flag = false;
        this.$set(this.errors, 'dzial_id', 'Proszę podać dział.');
      }

      return flag;
    },
    createJob() {
      let job = {
        dzial_id: null,
        nazwa_stanowiska: null,
        godz_rozpoczecia_naliczania_oplaty: null,
        godz_zakonczenia_naliczania_oplaty: null,
        stawka_godz: null
      };

      for (let prop in job) {
        job[prop] = this.job[prop];
      }

      return job;
    },
    addJob() {
      this.$http.post(this.globalURL + '/api/jobs', this.createJob())
        .then(res => {
          if (res.status == 201) {
            this.alert = {
              success: true,
              message: 'Dodano pomyślnie stanowisko.'
            };
          } else {
            this.alert = {
              success: false,
              message: 'Bład SQL: ' + res.status
            }
          }
        })
        .catch(err => {
          this.alert = {
            success: false,
            message: 'Błąd podczas połączenia z bazą danych'
          }
        });
    },
    updateJob() {
      this.$http.put(this.globalURL + '/api/jobs/' + this.$route.params.id, this.createJob())
        .then(res => {
          if (res.status == 200) {
            this.alert = {
              success: true,
              message: 'Stanowisko zostało zaktualizowane'
            };
          } else {
            this.alert = {
              success: false,
              message: 'Bład SQL: ' + res.status
            }
          }
        })
        .catch(err => {
          this.alert = {
            success: false,
            message: 'Błąd podczas połączenia z bazą danych'
          }
        });
    },
    getJob() {
      this.$http.get(this.globalURL + '/api/jobs/' + this.$route.params.id)
        .then(res => {
          if (res.status == 200) {
            this.job = res.body[0];
          } else {
            this.alert = {
              success: false,
              message: 'Bład SQL: ' + res.status
            }
          }
        })
        .catch(err => {
          this.alert = {
            success: false,
            message: 'Błąd podczas połączenia z bazą danych'
          }
        });
    },
    reset(e) {
      e.preventDefault();
      for (let prop in this.job) {
        this.job[prop] = '';
      }
      this.resetErrors();
    }
  },
  mounted() {
    this.getDepts();
    if (this.$route.params.id)
      this.getJob();
  }
}
</script>

<style></style>
