class lang.Objects {
	static function copy(src: Object, dist: Object): Object {
		iterate(src, function (name, value){ dist[name] = value })
		return dist
	}
	
	static function createCopy(src: Object): Object {
		var r = new Object()
		copy(src, r)
		return r
	}
	
	static function iterate(src: Object, f: Function): Void {
		for (var i in src) f(i, src[i])
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
}