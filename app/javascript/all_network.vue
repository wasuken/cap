<template>
	<div id="app">
		<h2>interfaces</h2>
		<ul>
			<li v-for="i in interfaces" :key="i">
				{{i}}
			</li>
		</ul>
		<h2>connection nodes</h2>
		<ul>
			<li v-for="ip in ips" :key="ip">
				{{ip}} => {{ (packets.filter(x => x.dip == ip).length / packets.length) * 100 }}%
			</li>
		</ul>
		<d3-network :net-nodes="nodes" :net-links="links" :options="options"></d3-network>
	</div>
</template>
<script>
 import D3Network from 'vue-d3-network';
 export default{
	 name: "network",
	 components:{
		 'd3-network': D3Network
	 },
	 data: function(){
		 return{
			 interfaces: [],
			 ips: [],
			 packets: [],
			 nodes: [],
			 links: [],
			 options:
		 {
			 force: 3000,
			 size:{ w:1000, h:600},
			 nodeSize: 10,
			 nodeLabels: true,
			 linkLabels: true,
			 linkWidth:5
		 },
		 }
	 },
	 methods: {
		 asyncPackets: function(){
			 let token = document.getElementById("token").value;
			 fetch("/api/v1/net_packets?token=" + token)
				 .then(resp => resp.json())
				 .then(json => {
					 this.packets = json;
					 this.interfaces = this.uniq(json.map(x => x.iface_name));
					 this.interfaces.sort();
					 this.ips = this.uniq(json.map(x => x.sip));
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
						 this.nodes.push({id: i+ifaces.length, name: x.dip})
						 this.links.push({sid: iface_map[x.iface],
										  tid: i+ifaces.length,
										  name: "" + ((this.packets.filter(y => y.dip == x.dip).length / this.packets.length) * 100) + "%"});
					 });
				 });
		 },
		 uniq: function(array) {
			 const knownElements = {};
			 const uniquedArray = [];
			 for (let i = 0, maxi = array.length; i < maxi; i++) {
				 if (array[i] in knownElements)
					 continue;
				 uniquedArray.push(array[i]);
				 knownElements[array[i]] = true;
			 }
			 return uniquedArray;
		 }
	 },
	 mounted: function(){
		 this.asyncPackets();
		 window.setInterval(this.asyncPackets, 20000);
	 }
 }
</script>
<style src="vue-d3-network/dist/vue-d3-network.css"></style>
