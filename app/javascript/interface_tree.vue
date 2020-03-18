<template>
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
			 nodeSize: 15,
			 nodeLabels: true,
			 linkWidth:5
		 }
		 }
	 },
	 mounted: function(){
		 console.log("hoge");
		 console.log(this.nodes);
	 }
 }
</script>
