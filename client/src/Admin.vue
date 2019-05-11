<template>
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

// Layout
import Sidebar from './components/Admin/Sidebar.vue'

export default {
  name: 'App',
  components: {
    Sidebar,
  }
}
</script>

<style></style>
