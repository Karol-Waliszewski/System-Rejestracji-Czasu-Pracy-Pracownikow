<template lang="html">
  <aside class="column is-2 aside">
    <nav class="menu">
      <p class="menu-label">
        Pracownicy
      </p>
      <ul class="menu-list">
        <li><router-link to="/worker" exact><span class="icon"><fai icon="users"/></span> Lista</router-link></li>
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
