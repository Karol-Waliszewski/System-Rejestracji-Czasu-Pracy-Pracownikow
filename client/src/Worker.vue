<template lang="html">
  <div class="wrapper">
    <div class="columns">
      <Sidebar/>
      <main class="column">
        <router-view></router-view>
      </main>
    </div>
  </div>
</template>

<script>
import Sidebar from './components/Worker/Sidebar.vue'

export default {
  name: 'Workers',
  components: {
    Sidebar
  }
}
</script>

<style lang="css">
</style>
