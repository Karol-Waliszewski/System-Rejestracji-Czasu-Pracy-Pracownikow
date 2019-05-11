// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'
import fontawesome from '@fortawesome/fontawesome'
import solid from '@fortawesome/fontawesome-free-solid'
// flatpickr language
import Polish from 'flatpickr/dist/l10n/pl.js'

// App layout
import App from './App.vue'

// Main Routes
import Home from './Home.vue'
import Admin from './Admin.vue'
import Worker from './Worker.vue'

// Sub routes
// ----- ADMIN
import workers_add from './components/Admin/AddUser.vue'
import workers from './components/Admin/Workers.vue'
import depts from './components/Admin/Departments.vue'
import depts_add from './components/Admin/AddDept.vue'
import jobs from './components/Admin/Jobs.vue'
import jobs_add from './components/Admin/AddJob.vue'
import payments from './components/Admin/Payments.vue'
import entries from './components/Admin/Entries.vue'

// ----- WORKER
import worker_workers from './components/Worker/Workers.vue'

fontawesome.library.add(solid);

Vue.config.productionTip = false

Vue.use(VueResource);
Vue.use(VueRouter);

const routes = [{
  path: '/',
  component: Home
}, {
  path: '/admin',
  component: Admin,
  children: [{
      path: '',
      component: payments
    },
    {
      path: 'jobs',
      component: jobs
    },
    {
      path: 'workers',
      component: workers
    },
    {
      path: 'depts',
      component: depts
    },
    {
      path: 'jobs/add',
      component: jobs_add
    },
    {
      path: 'jobs/edit/:id',
      component: jobs_add
    },
    {
      path: 'depts/add',
      component: depts_add
    },
    {
      path: 'depts/edit/:id',
      component: depts_add
    },
    {
      path: 'workers/add',
      component: workers_add
    },
    {
      path: 'workers/edit/:id',
      component: workers_add
    },
    {
      path: 'entries',
      component: entries
    }
  ]
}, {
  path: '/worker',
  component: Worker,
  children: [{
    path: '',
    component: worker_workers
  }]
}];

const router = new VueRouter({
  routes,
  mode: 'history',
  linkActiveClass: "is-active",
  linkExactActiveClass: "is-active"
});

Vue.mixin({
  data: function() {
    return {
      get globalURL() {
        return "http://localhost:8000";
      },
      get language() {
        return Polish.pl;
      }
    }
  }
});

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: {
    App
  },
  template: '<App/>'
})
