<template>
	<GChart type="LineChart"
			:data="chartData"
			:options="chartOptions">
	</GChart>
</template>
<script>
 import { GChart } from 'vue-google-charts';
 export default{
	 components: {
		 GChart
	 },
	 props: {
		 chartData: Array,
	 },
	 data: function(){
		 return{
			 chartOptions: {
				 title: "IPAddress connection days.",
			 },
		 }
	 }
 }
</script>
