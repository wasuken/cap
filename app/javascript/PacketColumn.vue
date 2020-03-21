<template>
	<GChart type="ColumnChart"
			:data="chartData"
			:options="chartOptions">
	</GChart>
</template>
<script>
 import { GChart } from 'vue-google-charts';
 export default {
	 components: {
		 GChart
	 },
	 props: {
		 chartData: Array,
	 }
	 data() {
		 return {
			 chartOptions: {
				 title: 'Packet Connection Top 10(IP)',
			 }
		 };
	 }
 };
</script>
