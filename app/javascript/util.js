export default {
	methods:{
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
	}
}
