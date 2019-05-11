<template lang="html">
  <div id="app">
    <Nav/>
    <router-view></router-view>
</div>
</template>

<script>
// Layout
import Nav from './components/Nav'

export default {
  components: {
    Nav
  }
}
</script>

<style lang="css">
@import './css/bulma.min.css';
@import './css/main.css';
</style>
