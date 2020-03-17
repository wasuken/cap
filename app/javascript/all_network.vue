<template>
	<div>
		<h2>interfaces</h2>
		<ul>
			<li v-for="i in interfaces" :key="i">
				{{i}}
			</li>
		</ul>
		<h2>connection nodes</h2>
		<ul>
			<li v-for="ip in ips" :key="ip">
				{{ip}} => {{ (packets.filter(x => x.dip == ip).length / packets.length) * 100 }}%
			</li>
		</ul>
	</div>
</template>
<script>
 export default{
	 name: "network",
	 data: function(){
		 return{
			 interfaces: [],
			 ip: [],
			 packets: []
		 }
	 },
	 methods: {
		 asyncPackets: function(){
			 fetch("/api/v1/net_packets")
				 .then(resp => resp.json())
				 .then(json => {
					 this.packets = json;
					 this.interfaces = this.uniq(json.map(x => x.iface_name))
					 this.interfaces.sort();
					 this.ips = this.uniq(json.map(x => x.sip));
					 this.ips.sort();
				 });
		 },
		 uniq: function(array) {
			 const knownElements = {};
			 const uniquedArray = [];
			 for (let i = 0, maxi = array.length; i < maxi; i++) {
				 if (array[i] in knownElements)
					 continue;
				 uniquedArray.push(array[i]);
				 knownElements[array[i]] = true;
			 }
			 return uniquedArray;
		 }
	 },
	 mounted: function(){
		 this.asyncPackets();
		 window.setInterval(this.asyncPackets, 20000);
	 }
 }
</script>
