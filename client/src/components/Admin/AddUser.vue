<template>
<div>
  <div class="card">
    <header class="card-header">
      <p class="card-header-title" v-if="$route.params.id">
        Edytuj pracownika
      </p>
      <p class="card-header-title" v-else>
        Dodaj pracownika
      </p>
    </header>
    <div class="card-content">
      <form class="content">

        <div class="field">
          <label class="label" for="imie">Imie</label>
          <div class="control">
            <input id="imie" class="input" :class="{'is-danger' : errors.imie}" type="text" placeholder="Podaj swoje imię..." v-model="user.imie">
          </div>
          <p v-if="errors.imie" class="help is-danger">
            {{errors.imie}}
          </p>
        </div>

        <div class="field">
          <label class="label" for="nazwisko">Nazwisko</label>
          <div class="control">
            <input id="nazwisko" class="input" :class="{'is-danger' : errors.nazwisko}" type="text" placeholder="Podaj swoję nazwisko..." v-model="user.nazwisko">
          </div>
          <p v-if="errors.nazwisko" class="help is-danger">
            {{errors.nazwisko}}
          </p>
        </div>

        <div class="field">
          <label class="label">Stanowisko</label>
          <div class="select" :class="{'is-danger' : errors.stanowisko_id}">
            <select v-model="user.stanowisko_id">
              <option v-for="job in jobs" :value="job.stanowisko_id">{{job.nazwa_stanowiska}}</option>
            </select>
          </div>
          <p v-if="errors.stanowisko_id" class="help is-danger">
            {{errors.stanowisko_id}}
          </p>
        </div>

        <div class="field">
          <label class="label">Data urodzin</label>
          <div class="select" :class="{'is-danger' : errors.data_urodzenia}">
            <datepicker v-model="user.data_urodzenia" :config="{language,altFormat: 'Y,m,d'}"></datepicker>
          </div>
          <p v-if="errors.data_urodzenia" class="help is-danger">
            {{errors.data_urodzenia}}
          </p>
        </div>

        <div class="field">
          <label class="label">Płeć</label>
          <div class="control">
            <label class="radio">
              <input type="radio" value="m" checked v-model="user.plec">
              Mężczyzna
            </label>
            <label class="radio">
              <input type="radio" value="k" v-model="user.plec" >
              Kobieta
            </label>
          </div>
        </div>

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
      user: {
        imie: '',
        nazwisko: '',
        plec: 'm',
        stanowisko_id: '',
        data_urodzenia: ''
      },
      errors: {},
      alert: {},
      jobs: [],
    }
  },
  components: {
    Datepicker
  },
  methods: {
    submit(e) {
      e.preventDefault();
      if (this.validate()) {
        if (this.$route.params.id)
          this.updateUser();
        else
          this.addUser();
        this.reset();
      }
    },
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
    validate() {
      var flag = true;
      let {
        errors,
        user
      } = this;

      this.$delete(errors, 'imie');
      this.$delete(errors, 'nazwisko');
      this.$delete(errors, 'stanowisko_id');
      this.$delete(errors, 'data_urodzenia');

      // Validation
      if (user.imie.length == 0) {
        flag = false;
        this.$set(errors, 'imie', 'Proszę podać imię.');
      }
      if (user.nazwisko.length == 0) {
        flag = false;
        this.$set(errors, 'nazwisko', 'Proszę podać nazwisko.');
      }
      if (user.stanowisko_id.length == 0) {
        flag = false;
        this.$set(errors, 'stanowisko_id', 'Proszę podać stanowsko.');
      }
      if (user.data_urodzenia.length == 0) {
        flag = false;
        this.$set(errors, 'data_urodzenia', 'Proszę podać datę urodzin.');
      }

      return flag;
    },
    getUser() {
      this.$http.get(this.globalURL + '/api/workers/' + this.$route.params.id)
        .then(res => {
          let data = res.body[0];
          for (let prop in data) {
            this.user[prop] = data[prop];
          }
        })
        .catch(err => {
          console.log(err);
        });
    },
    createUser() {
      let user = {
        imie: '',
        nazwisko: '',
        plec: 'm',
        stanowisko_id: '',
        data_urodzenia: ''
      };

      for (let prop in user) {
        user[prop] = this.user[prop];
      }

      return user;
    },
    addUser() {
      let {
        alert,
      } = this;

      this.$http.post(this.globalURL + '/api/workers', this.createUser())
        .then(res => {
          if (res.status == 201) {
            this.alert = {
              success: true,
              message: 'Dodano pomyślnie pracownika'
            };
          } else {
            this.alert = {
              success: false,
              message: 'Bład SQL:' + res.status
            }
          }
        })
        .catch(err => {
          this.alert = {
            success: false,
            message: 'Bład podczas połączenia z bazą danych'
          }
        });
    },
    updateUser() {
      let {
        alert,
      } = this;

      let user = this.createUser();

      if (user.data_dodania)
        user.data_dodania = user.data_dodania.slice(0, 10);

      this.$http.put(this.globalURL + '/api/workers/' + this.$route.params.id, user)
        .then(res => {
          if (res.status == 200) {
            this.alert = {
              success: true,
              message: 'Pracownik został pomyślnie zaktualizowany'
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
            message: 'Bład podczas połączenia z bazą danych'
          }
        });
    },
    reset(e) {
      e.preventDefault();
      let {
        user
      } = this;
      user.imie = '';
      user.nazwisko = '';
      user.plec = 'male';
      user.stanowisko_id = '';
      user.data_urodzenia = '';
      this.errors = {};
      this.$delete(this.errors, 'imie');
      this.$delete(this.errors, 'surrname');
      this.$delete(this.errors, 'stanowisko_id');
      this.$delete(this.errors, 'data_urodzenia');
    }
  },
  mounted() {
    this.getJobs();
    if (this.$route.params.id) {
      this.getUser();
    }
  }
}
</script>

<style>

</style>
