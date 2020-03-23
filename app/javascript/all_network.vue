<template>
	<div id="app">
		<h2>host/interfaces</h2>
		<ul>
			<li v-for="h_i in h_is" :key="h_i">
				<router-link :to="'/iface/' + h_i">{{h_i}}</router-link>
			</li>
		</ul>
		<h2>connection nodes(ip address => packet persenage)</h2>
		<ul>
			<li v-for="ip in ips" :key="ip">
				{{ip}} => {{ (packets.filter(x => x.dip == ip).length / packets.length) * 100 }}%
			</li>
		</ul>
	</div>
</template>
<script>
 import D3Network from 'vue-d3-network';
 import util from "./util.js"
 export default {
	 name: "network",
	 components:{
		 'd3-network': D3Network
	 },
	 mixins: [util],
	 data: function(){
		 return{
			 h_is: [],
			 interfaces: [],
			 ips: [],
			 packets: [],
			 nodes: [],
			 links: [],
		 }
	 },
	 methods: {
		 asyncAllPackets: function(){
			 let token = document.getElementById("token").value;
			 fetch("/api/v1/net_packets?token=" + token)
				 .then(resp => resp.json())
				 .then(json => {
					 this.packets = json;
					 this.h_is = this.uniq(this.packets.map(x => x.h_i));
					 this.interfaces = this.uniq(json.map(x => x.iface_name));
					 this.interfaces.sort();
					 this.ips = this.uniq(json.map(x => x.dip));
					 this.ips.sort();
					 let ifaces = this.uniq(this.packets.map(x => x.iface_name));
					 this.nodes = [];
					 this.link = [];
					 let iface_map = {}
					 ifaces.forEach((x, i) => {
						 this.nodes.push({id: i, name: x})
						 iface_map[x] = i;
					 });
					 let iface_ips = this.ips.map(x => {
						 return {iface: this.packets.find(y => y.dip == x).iface_name, dip: x};
					 });
					 iface_ips.forEach((x, i) => {
						 this.nodes.push({id: i+ifaces.length, name: x.dip});
						 let per = ((parseFloat(this.packets.filter(y => y.dip == x.dip).length) /
							 this.packets.length) * 100) + "%";
						 this.links.push({sid: iface_map[x.iface],
										  tid: i+ifaces.length,
										  name: per});
					 });
				 });
		 },
	 },
	 mounted: function(){
		 this.asyncAllPackets();
		 window.setInterval(this.asyncAllPackets, 20000);
	 }
 }
</script>
<style src="vue-d3-network/dist/vue-d3-network.css"></style>
