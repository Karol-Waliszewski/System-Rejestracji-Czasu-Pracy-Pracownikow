<template lang="html">
  <div>
  <div class="card">
    <header class="card-header">
      <p class="card-header-title">
        Pracownicy
      </p>
    </header>
    <div class="card-content">
      <div class="content">
        <table class="table is-responsive">
          <thead>
            <tr>
              <th>Imię</th>
              <th>Nazwisko</th>
              <th>Wejdź</th>
              <th>Wyjdź</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="worker in workers">
              <td>{{worker.imie}}</td>
              <td>{{worker.nazwisko}}</td>
              <td>
                <button type="button" class="button is-success" @click="enter(worker.pracownik_id)"> <fai icon="sign-in-alt"/> </button>
              </td>
              <td>
                <button type="button" class="button is-danger" @click="leave(worker.pracownik_id)"> <fai icon="sign-out-alt"/> </button>
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

  <div v-if="modal.message" class="modal" :class="{'is-active':modal.isOpen}">
   <div class="modal-background"></div>
   <div class="modal-content">
     <div class="notification is-danger">
        <button class="delete" @click="closeModal"></button>
        {{modal.message}}
     </div>
   </div>
 </div>
</div>
</template>

<script>
import FontAwesomeIcon from '@fortawesome/vue-fontawesome'

export default {
  name: 'Workers',
  data() {
    return {
      workers: [],
      alert: {},
      modal: {isOpen: false,message:null}
    }
  },
  components: {
    fai: FontAwesomeIcon
  },
  methods: {
    getWorkers() {
      this.$http.get(this.globalURL + '/api/workers').
      then(res => {
        if (res.status == 200) {
          this.workers = res.body;
        } else {
          this.alert = {
            success: false,
            message: 'Nie udało się pobrać pracowników z serwera'
          };
        }
      }).catch(err => {
        this.alert = {
          success: false,
          message: 'Nie można połączyć się z bazą danych.'
        };
      });
    },
    enter(id) {
      this.$http.post(this.globalURL + '/api/entries', {
          We_Wy: "We",
          pracownik_id: id
        })
        .then(res => {
          if(res.status == 201){
            this.alert = {
              success: true,
              message: 'Przyjęto akcję. Miłej pracy.'
            };
          }
        })
        .catch(err => {
          if(err.status == 406){
            this.openModal(`Wystąpił błąd podczas wchodzenia (powielona akcja), skontaktuj się z administatorem.`);
          }
        });
    },
    leave(id) {
      this.$http.post(this.globalURL + '/api/entries', {
          We_Wy: "Wy",
          pracownik_id: id
        })
        .then(res => {
          if(res.status == 201){
            this.alert = {
              success: true,
              message: 'Przyjęto akcję. Miłego dnia.'
            };
          }
        })
        .catch(err => {
          if(err.status == 406){
            this.openModal(`Wystąpił błąd podczas wychodzenia (powielona akcja), skontaktuj się z administatorem.`);
          }
        });
    },
    openModal(msg){
      this.modal.isOpen = true;
      this.modal.message = msg;
      this.alert = {};
    },
    closeModal(){
      this.modal.isOpen = false;
      this.modal.message = null;
    }
  },
  mounted() {
    this.getWorkers();
  },
}
</script>

<style lang="css">
</style>
