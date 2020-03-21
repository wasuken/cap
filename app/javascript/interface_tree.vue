<template>
	<h2>connection nodes(ip address/packet persenage)</h2>
	<ul>
		<li v-for="ip in ips" :key="ip">
			{{ip}} => {{ (packets.filter(x => x.dip == ip).length / packets.length) * 100 }}%
		</li>
	</ul>
	<d3-network :net-nodes="nodes" :net-links="links" :options="options"></d3-network>
</template>
<script>
 import D3Network from 'vue-d3-network'
 export default{
	 name: "d3Network",
	 components: {
		 'd3-network': D3Network
	 },
	 props: {
		 nodes: Array,
		 links: Array,
	 },
	 data: function(){
		 return{
			 options:
 {
	 force: 3000,
	 size:{ w:600, h:600},
	 nodeSize: 10,
	 nodeLabels: true,
	 linkLabels: true,
	 linkWidth:5
 },
		 }
	 },
	 methdods: {
		 asyncPackets: function(){
			 let token = document.getElementById("token").value;
			 fetch("/api/v1/net_packets?token=" + token)
				 .then(resp => resp.json())
				 .then(json => {

				 });
		 },
	 }
	 mounted: function(){
		 console.log(this.nodes);
	 }
 }
</script>
