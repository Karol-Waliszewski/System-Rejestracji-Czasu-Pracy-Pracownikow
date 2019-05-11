<template lang="html">
  <aside class="column is-2 aside">
    <nav class="menu">
      <p class="menu-label">
        Główne
      </p>
      <ul class="menu-list">
        <li><router-link to="/admin" exact><span class="icon"><fai icon="money-bill-wave"/></span> Wypłaty</router-link></li>
        <li><router-link to="/admin/entries" exact><span class="icon"><fai icon="sign-in-alt"/></span> Wejścia</router-link></li>
      </ul>
      <p class="menu-label">
        Pracownicy
      </p>
      <ul class="menu-list">
        <li><router-link to="/admin/workers" exact><span class="icon"><fai icon="users"/></span> Lista</router-link></li>
        <li><router-link to="/admin/workers/add"><span class="icon"><fai icon="user-plus"/></span> Dodaj</router-link></li>
      </ul>
      <p class="menu-label">
        Stanowiska
      </p>
      <ul class="menu-list">
        <li><router-link to="/admin/jobs" exact><span class="icon"><fai icon="briefcase"/></span> Lista</router-link></li>
        <li><router-link to="/admin/jobs/add"><span class="icon"><fai icon="plus"/></span> Dodaj</router-link></li>
      </ul>
      <p class="menu-label">
        Działy
      </p>
      <ul class="menu-list">
        <li><router-link to="/admin/depts" exact><span class="icon"><fai icon="building"/></span> Lista</router-link></li>
        <li><router-link to="/admin/depts/add"><span class="icon"><fai icon="plus"/></span> Dodaj</router-link></li>
      </ul>
    </nav>
  </aside>
</template>

<script>
import FontAwesomeIcon from '@fortawesome/vue-fontawesome'

export default {
  name: 'Sidebar',
  components: {
    fai: FontAwesomeIcon
  }
}
</script>

<style lang="css">
</style>
