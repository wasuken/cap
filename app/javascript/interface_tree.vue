<template>
	<div>
		<pie :chartData="pieChartData"></pie>
		<cl :chartData="clChartData"></cl>
		<nw :iface="iface" :nodes="nodes" :links="links"></nw>
	</div>
</template>
<script>
 import pie from "./PacketPie.vue";
 import nw from "./network_graph.vue";
 import cl from "./PacketColumn.vue";
 import util from "./util.js"
 export default{
	 name: "d3Network",
	 mixins: [util],
	 components: {
		 pie,
		 nw,
		 cl
	 },

	 props: {
		 host: String,
		 iface: String,
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
			 pieChartData: [],
			 clChartData: [],
			 packets: [],
			 nodes: [],
			 links: [],
		 }
	 },
	 methods: {
		 asyncPackets: function(){
			 let token = document.getElementById("token").value;
			 fetch("/api/v1/net_packets?token=" + token +
				   "&iface=" + this.iface +
				   "&host=" + this.host)
				 .then(resp => resp.json())
				 .then(json => {
					 this.packets = json;
				 })
				 .then(x => this.procData());
		 },
		 procData:function(){
			 /* common */
			 let ips = this.uniq(this.packets.map(x => x.dip));
			 /* initialize */
			 this.pieChartData = [];
			 this.clChartData = [];
			 this.nodes = [];
			 this.links = [];
			 /* pie chart processing */
			 let uniqPorts = this.uniq(this.packets.map(x => x.dport).filter(x => x <= 1024));
			 let pcData = uniqPorts.map(x =>
				 ["" + x, this.packets.filter(y => y.dport == x).length]);
			 this.pieChartData = [
				 ["Port Number", "Count"],
				 ...pcData.sort((a, b) => b[1] - a[1])
			 ];
			 /* column chart processing */
			 let clData = ips.map(ip =>
				 ["" + ip, this.packets.filter(p => p.dip == ip).length]);
			 this.clChartData = [
				 ["IP", "Count"],
				 ...clData.sort((a, b) => b[1] - a[1]).slice(0, 10)
			 ];
			 /* network-d3 processing */
			 this.nodes.push({id: 0, name: this.iface})
			 ips.forEach((x, i) => {
				 this.nodes.push({id: i+1, name: x})
				 let per = ((this.packets.filter(y => y.dip == x).length /
					 this.packets.length) * 100) + "%";
				 this.links.push({sid: 0,
								  tid: i+1,
								  name: per});
			 })
		 }
	 },
	 mounted: function(){
		 this.asyncPackets();
		 window.setInterval(this.asyncPackets, 20000);
	 }
 }
</script>
