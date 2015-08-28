class lang.Objects {
	static function copy(src: Object, dist: Object) {
		iterate(src, function (name, value){ dist[name] = value })
		return dist
	}
	
	static function createCopy(): Object {
		var r = new Object()
		for (var i = 0; i < arguments.length; i++)
			copy(arguments[i], r)
		return r
	}
	
	static function iterate(src: Object, f: Function): Void {
		for (var i in src) f(i, src[i])
	}
	
	static function reverseIterate(src: Object, f: Function): Void {
		var a = new Array()
		for (var i in src) a.push(src[i])
		iterate(a, f)
	}
	
	static function size(src: Object): Number {
		var k = 0
		iterate(src, function(){ k++ })
		return k
	}
	
	static function isEmpty(src: Object): Boolean {
		return size(src) == 0
	}
	
	static function print(src: Object): Void {
		iterate(src, function(name, value){ trace(name + " -> " + value) })
		trace("---")
	}
	
	static function remove(src: Object): Object {
		for (var i = 1; i < arguments.length; i++){
			delete src[arguments[i]]
		}
		return src
	}
	
	static function set(src: Object): Object {
		for (var i = 1; i < arguments.length; i += 2) {
			src[arguments[i]] = arguments[i + 1]
		}
		return src
	}
	
	static function create(): Object {
		var res = new Object()
		for (var i = 0; i < arguments.length; i += 2) {
			res[arguments[i]] = arguments[i + 1]
		}
		return res
	}
}