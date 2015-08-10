import lang.*

class lang.Arrays {
	
	static function concat(dest: Array, src: Array): Array {
		if (dest == undefined) dest = new Array()
		
		var a = new Array()
		for (var i in src) a.push(src[i])
		for (var i in a) dest.push(a[i])
		return dest
	}
}