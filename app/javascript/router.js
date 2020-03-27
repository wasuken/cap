import VueRouter from 'vue-router';

import base from "./all_network.vue";
import iface from "./interface_tree.vue";
import ip from "./IPViewer.vue";

const routes = [
	{ path: '/', component: base },
	{ path: '/iface/:host/:iface', component: iface, props: true},
	{ path: '/ip/:host/:iface/:ip', component: ip, props: true},
];

export default new VueRouter({ routes });
