<template lang="html">
  <div class="section center">
    <div class="container">
      <h1 class="title is-1">
        System Rejestracji Czasu Pracy Pracowników
      </h1>
      <h2 class="subtitle is-2">
        <a href="https://github.com/kzsobolewski">Krzysztof Sobolewski</a>
        <br/>
        <a href="https://github.com/Karol-Waliszewski">Karol Waliszewski</a>
        <br>
      </h2>
      <router-link class="button" to="/admin">Admin</router-link>
      <router-link class="button" to="/worker">Pracownik</router-link>
    </div>
 </div>
</template>

<script>
export default {}
</script>

<style lang="scss" scoped>
.center {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 90vh;
}
.is-4 {
    margin-top: -1.25rem;
}
.subtitle {
    a {
        color: inherit;
        &:hover {
          text-decoration: underline;
        }
    }
}
</style>
