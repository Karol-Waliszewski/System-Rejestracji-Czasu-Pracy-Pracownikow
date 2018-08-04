<template>
<div>
  <div class="card">
    <header class="card-header">
      <p class="card-header-title">
        Dodaj Dział
      </p>
    </header>
    <div class="card-content">
      <form class="content">
        <div class="field">
          <label class="label" for="nazwa">Nazwa</label>
          <div class="control">
            <input id="nazwa" class="input" :class="{'is-danger' : errors.nazwa}" type="text" placeholder="Podaj nazwę..." v-model="dzial.nazwa">
          </div>
          <p v-if="errors.nazwa" class="help is-danger">
            {{errors.nazwa}}
          </p>
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
export default {
  name: 'AddUser',
  data() {
    return {
      dzial: {
        nazwa: '',
      },
      errors: {},
      alert: {}
    }
  },
  methods: {
    submit(e) {
      e.preventDefault();
      if (this.validate()) {
        if (this.$route.params.id)
          this.editDept();
        else
          this.addDept();
        this.reset();
      }
    },
    validate() {
      var flag = true;
      let {
        errors,
        dzial
      } = this;

      // Validation
      if (dzial.nazwa.length == 0) {
        flag = false;
        this.$set(errors, 'nazwa', 'Proszę podać nazwę.');
      }

      return flag;
    },
    getDept() {
      this.$http.get(this.globalURL + '/api/depts/' + this.$route.params.id)
        .then(res => {
          console.log(res)
          if (res.status == 200) {
            this.dzial = res.body[0];
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
    createDept(){
      let dept = {};
        dept.nazwa = this.dzial.nazwa;
      return dept;
    },
    addDept() {
      this.$http.post(this.globalURL + '/api/depts', this.createDept())
        .then(res => {
          if (res.status == 201) {
            this.alert = {
              success: true,
              message: 'Dodano pomyślnie dział'
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
    editDept() {
      this.$http.put(this.globalURL + '/api/depts/' + this.$route.params.id, this.createDept())
        .then(res => {
          if (res.status == 200) {
            this.alert = {
              success: true,
              message: 'Dział pomyślnie zaktualizowano'
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
      for (let prop in this.dzial) {
        this.dzial[prop] = '';
        this.$set(this.errors, prop);
      }
    }
  },
  mounted() {
    if (this.$route.params.id) this.getDept();
  }
}
</script>

<style></style>
