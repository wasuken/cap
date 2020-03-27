<template>
	<div>
		<!-- domain name -->
		{{domainName}}
		<!-- line graph -->
		<pLine :chartData="clines"></pLine>
	</div>
</template>
<script>
 import pLine from './PacketLine.vue';
 import util from "./util.js"
 export default {
	 components:{
		 pLine,
	 },
	 mixins: [util],
	 props:{
		 host: String,
		 iface: String,
		 ip: String,
	 },
	 data: function(){
		 return{
			 packets: [],
			 clines: [],
			 domainName: "",
		 }
	 },
	 methods: {
		 asyncPackets: function(){
			 let token = document.getElementById("token").value;
			 fetch("/api/v1/net_packets?token=" + token +
				   "&iface=" + this.iface +
				   "&host=" + this.host +
				   "&dip=" + this.ip)
				 .then(resp => resp.json())
				 .then(json => {
					 this.packets = json;
					 let header = ["Date", "Count"];
					 let data = this.uniq(this.packets.map(x => x["updated_at"].split("T")[0]))
									.map(x => [x, this.packets
													  .filter(y => x == y["updated_at"]
														  .split("T")[0])
													  .length])
									.sort((a, b) => Date.parse(a[0]) > Date.parse(b[0]))

					 this.clines = [
						 ["Date", "Count"],
						 ...data
					 ]
				 });
		 }
	 },
	 mounted: function(){
		 this.asyncPackets();
		 let rip = this.ip.split(".").reverse().join(".");
		 fetch(`https://dns.google.com/resolve?name=${rip}.in-addr.arpa.&type=12`)
			 .then(resp => resp.json())
			 .then(json => {
				 if(json["Status"] == 0){
					 this.domainName = json["Answer"][0]["data"];
				 }else{
					 this.domainName = "Not Found";
				 }
			 });
	 }
 }
</script>
