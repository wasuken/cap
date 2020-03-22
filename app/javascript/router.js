import VueRouter from 'vue-router';

import base from "./all_network.vue";
import iface from "./interface_tree.vue";

const routes = [
	{ path: '/', component: base },
	{ path: '/iface/:iface', component: iface, props: true},
];

export default new VueRouter({ routes });
