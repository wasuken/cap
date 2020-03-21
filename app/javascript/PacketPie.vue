<template>
	<GChart
		:settings="chartSettings"
		:type="chartType"
		:data="chartData"
		:options="chartOptions"
    />
</template>
<script>
 import { GChart } from 'vue-google-charts'
 export default {
	 components: {
		 GChart
	 },
	 props: {
		 chartType: {
			 type: String,
			 default: 'PieChart'
		 },
		 chartData: {
			 type: Array,
			 default: () => {
				 return []
			 }
		 },
		 chartOptions: {
			 type: Object,
			 default: () => {
				 return {title: 'Packet Pie'}
			 }
		 }
	 }
 }
</script>
