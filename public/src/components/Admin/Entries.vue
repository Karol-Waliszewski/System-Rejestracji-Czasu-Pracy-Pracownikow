<template lang="html">
<div>
  <div class="card">
    <header class="card-header">
      <p class="card-header-title">
        Wejścia
      </p>
      <div class="card-header-icon field has-addons">
        <div class="control">
          <div class="select">
            <select v-model="entryFilter">
              <option value="" disabled selected>Filtruj wejścia...</option>
              <option v-for="entry in filteredWorkers" :value="entry.pracownik_id">{{entry.imie}}  {{entry.nazwisko}}</option>
            </select>
          </div>
        </div>
        <div class="control">
          <button type="button" class="button" title="Reset filter" @click="resetFilter"><fai icon="times"/></button>
        </div>
      </div>
    </header>
    <div class="card-content">
      <div class="content">
        <table class="table is-responsive">
          <thead>
            <tr>
              <th>Imię</th>
              <th>Nazwisko</th>
              <th>Godzina</th>
              <th>Data</th>
              <th>Akcja</th>
              <th>Napraw</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(entry,index) in entries" v-if="entryFilter == '' || entry.pracownik_id == entryFilter">
              <td>{{entry.imie}}</td>
              <td>{{entry.nazwisko}}</td>
              <td>{{entry.godzina.slice(11,19)}}</td>
              <td>{{entry.godzina.slice(0,10)}}</td>
              <td v-if="entry.We_Wy == 'We'">
                <button type="button" class="button is-success" disabled> <fai icon="sign-in-alt"/> </button>
              </td>
              <td v-else>
                <button type="button" class="button is-danger" disabled> <fai icon="sign-out-alt"/> </button>
              </td>
              <td>
                <button  @click="deleteEntry(entry.odbicie_id)" type="button" class="button is-info"> <fai icon="wrench"/> </button>
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
      entries: [],
      entryFilter: '',
    }
  },
  components: {
    fai: FontAwesomeIcon
  },
  methods: {
    getEntries() {
      this.$http.get(this.globalURL + '/api/entries')
        .then(res => {
          if (res.status == 200) {
            this.entries = res.body.sort(function (a,b) {
              return a.odbicie_id - b.odbicie_id;
            }).reverse();
          } else {
            this.alert = {
              success: false,
              message: 'Nie udało się pobrać wejść z serwera'
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
    // isWrong(index) {
    //   if (this.entries[index].We_Wy == 'Wy') {
    //     var isFirst = true;
    //     for (let i = index +1; i < this.entries.length; i++) {
    //       if (this.entries[index].pracownik_id == this.entries[i].pracownik_id) {
    //         isFirst = false;
    //       }
    //     }
    //     if (isFirst)
    //       return true;
    //   }
    //
    //   if (index == 0) {
    //     return (this.entries[0].We_Wy == this.entries[1].We_Wy && this.entries[0].pracownik_id == this.entries[1].pracownik_id);
    //   }
    //   if (index == this.entries.length - 1) {
    //     return (this.entries[this.entries.length - 1].We_Wy == this.entries[this.entries.length - 2].We_Wy && this.entries[this.entries.length - 1].pracownik_id == this.entries[this.entries.length - 2].pracownik_id);
    //   }
    //
    //   return (this.entries[index].We_Wy == this.entries[index - 1].We_Wy && this.entries[index].pracownik_id == this.entries[index - 1].pracownik_id) || (this.entries[index].We_Wy == this.entries[index + 1].We_Wy && this.entries[index].pracownik_id ==
    //     this.entries[index + 1].pracownik_id);
    // },
    deleteEntry(id) {
      this.$http.delete(this.globalURL + '/api/entries/' + id)
        .then(res => {
          if (res.status == 200) {
            this.alert = {
              success: true,
              message: 'Błąd został naprawiony!'
            };
            setTimeout(() => {
              this.alert = {};
            }, 7000)
            this.getEntries();
          } else {
            this.alert = {
              success: false,
              message: 'Nie udało się pobrać wejść z serwera'
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
    resetFilter() {
      this.entryFilter = '';
    }
  },
  computed: {
    filteredWorkers: function() {
      let workers = this.entries.filter((thing, index, self) =>
        index === self.findIndex((t) => (
          t.pracownik_id === thing.pracownik_id
        ))
      );

      return workers;
    }
  },
  mounted() {
    this.getEntries();
  }
}
</script>

<style lang="css">
</style>
