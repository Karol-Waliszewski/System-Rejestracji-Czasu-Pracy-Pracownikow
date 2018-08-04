<template lang="html">
  <div class="card">
    <header class="card-header">
      <p class="card-header-title">
        Wypłaty
      </p>
    </header>
    <div class="card-content">
      <div class="content">
        <table class="table is-responsive">
          <thead>
            <tr>
              <th>Imię</th>
              <th>Nazwisko</th>
              <th>Stanowisko</th>
              <th>Godziny</th>
              <th>Stawka</th>
              <th>Wynagrodzenie</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="payment in payments" :class="{'is-danger': !payment.czyPoprawne}">
              <td>{{payment.imie}}</td>
              <td>{{payment.nazwisko}}</td>
              <td>{{payment.nazwa_stanowiska}}</td>
              <td v-if="payment.przepracowaneGodziny != undefined">{{payment.przepracowaneGodziny}}</td>
              <td v-else>BŁĄD</td>
              <td>{{payment.stawka_godz}}</td>
              <td v-if="payment.naleznosc != undefined">{{payment.naleznosc}} zł</td>
              <td v-else>BŁĄD</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

</template>

<script>
export default {
  name: 'Payments',
  data() {
    return {
      payments: []
    }
  },
  methods: {
    getPayments() {
      this.$http.get(this.globalURL + '/api/payments').
      then(res => {
        if (res.status == 200) {
          this.payments = res.body;
        } else {
          this.alert = {
            success: false,
            message: 'Nie udało się pobrać danych z serwera'
          };
        }
      }).catch(err => {
        this.alert = {
          success: false,
          message: 'Nie można połączyć się z bazą danych.'
        };
      });
    }
  },
  mounted() {
    this.getPayments();
  }
}
</script>

<style lang="css">
</style>
