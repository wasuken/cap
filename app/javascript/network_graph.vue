<template>
	<d3-network :net-nodes="nodes" :net-links="links" :options="options"></d3-network>
</template>
<script>
 import D3Network from 'vue-d3-network';
 export default{
	 name: "network",
	 components:{
		 'd3-network': D3Network
	 },
	 props: {
		 iface: String,
		 nodes: Array,
		 links: Array,
	 },
	 data: function(){
		 return{
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
	 }
 }
</script>
