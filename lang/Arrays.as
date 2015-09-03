import lang.*

class lang.Arrays {
	private static var _lol = new FuncInvoker(init)
	private static function init() {
		var proto = Array.prototype
		
		proto.last = function() { return this[this.length - 1] }
		
		_global.ASSetPropFlags(proto, null, 0x7)
	}
	
	
	static function concat(dest: Array, src: Array): Array {
		if (dest == undefined) dest = new Array()
		
		var a = new Array()
		for (var i in src) a.push(src[i])
		for (var i in a) dest.push(a[i])
		return dest
	}
	
	static function remove(ar: Array, e: Object): Array {
		for (var i in ar) {
			if (ar[i] == e) delete ar[i]
		}
		return ar
	}
	
	static function find(ar: Array, e: Object): String {
		for (var i in ar) {
			if (ar[i] == e) return i
		}
		return null
	}
	
	static function check(ar: Array, ok: Boolean): Boolean {
		var args = arguments.slice(2)
		for (var i in ar) {
			if (ar[i].apply(null, args) != ok) return !ok
		}
		return ok
	}
}