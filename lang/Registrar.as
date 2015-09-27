import lang.*

class Registrar extends Array {
	
	function register(v: Object) { 
		var _this = this
		var i = push(v) - 1
		return function(){ 
			delete _this[i]
			i = -1
		}
	}
	
	function forEach(f: Function) {
		for (var i in this) f(this[i])
	}
}