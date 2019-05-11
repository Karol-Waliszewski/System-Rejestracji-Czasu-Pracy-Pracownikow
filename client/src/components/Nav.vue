<template lang="html">

    <header class="hero is-light">
      <div class="hero-head">
        <nav class="navbar has-shadow " role="navigation" aria-label="main navigation">
          <div class="navbar-brand">
            <router-link class="navbar-item is--brand" to="/" exact-active-class="" active-class="" exact>
              <img class="navbar-brand-logo" src="../assets/logo.svg" alt="Logo">
            </router-link>
            <router-link class="navbar-item is-tab is-hidden-mobile" to="/" exact>Home</router-link>
            <router-link class="navbar-item is-tab is-hidden-mobile" to="/admin">Admin</router-link>
            <router-link class="navbar-item is-tab is-hidden-mobile" to="/worker">Pracownik</router-link>

            <button class="button navbar-burger is-light" :class="{'is-active':isActive}" data-target="navMenu" @click="toggleActive">
                <span></span>
                <span></span>
                <span></span>
            </button>

          </div>

          <div class="navbar-menu navbar-end" id="navMenu" :class="{'is-active':isActive}">
            <router-link class="navbar-item is-tab is-hidden-tablet" to="/" exact>Home</router-link>
            <router-link class="navbar-item is-tab is-hidden-tablet" to="/admin">Admin</router-link>
            <router-link class="navbar-item is-tab is-hidden-tablet" to="/worker">Pracownik</router-link>
          </div>
        </nav>
      </div>
    </header>

</template>

<script>
export default {
  name: 'Nav',
  data() {
    return {
      isActive: false
    }
  },
  methods: {
    toggleActive() {
      this.isActive = !this.isActive;
    }
  }
}
</script>

<style lang="css">
</style>
