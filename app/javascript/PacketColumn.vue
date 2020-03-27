<template>
	<GChart type="ColumnChart"
				  :data="chartData"
			:options="chartOptions"
			:events="chartEvents">
	</GChart>
</template>
<script>
 import { GChart } from 'vue-google-charts';
 export default {
	 components: {
		 GChart
	 },
	 props: {
		 iface: String,
		 host: String,
		 chartData: Array,
	 },
	 data() {
		 return {
			 chartOptions: {
				 title: 'Packet Connection Top 10(IP)',
			 },
			 chartEvents: {
				 'click': (e) => {
					 let id = parseInt(e.targetID.split("#")[2]);
					 let ip = this.chartData[id+1][0];
					 this.$router.push({path: `/ip/${this.host}/${this.iface}/${ip}`});
				 }
			 }
		 };
	 }
 };
</script>
