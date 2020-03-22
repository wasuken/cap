<template>
	<GChart
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
		 },
		 chartOptions: {
			 type: Object,
			 default: () => {
				 return {title: 'Well-Known Port Pie'}
			 }
		 }
	 }
 }
</script>
