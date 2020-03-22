import Vue from 'vue';
/* import App from '../all_network.vue'; */
import App from '../StartPage.vue';
import VueRouter from 'vue-router';
import router from '../router';

Vue.use(VueRouter);

document.addEventListener('DOMContentLoaded', () => {
	const app = new Vue({
		router,
		render: h => h(App)
	}).$mount()
	document.body.appendChild(app.$el)

	console.log(app)
})
