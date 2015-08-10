class lang.Functions {
	static var _lol = new lang.FuncInvoker(init)
	
	static function init(){
		_global.traceAll = function(){ trace(arguments.join("  ")) }
	}
	
	static var WATCH_ARRAY = function(prop, oldVal, newVal) {
		oldVal.push(newVal)
		return oldVal
	}

	static function makeMultiListener(obj: Object, prop: String): Void {
		if (obj[prop] instanceof Array) return;
		var oldVal = obj[prop]
		var array = obj["__" + prop + "__"] = new Array()

		obj[prop] = function(){ for (var i = 0; i < array.length; i++) array[i].apply(this, arguments) }
		obj.watch(prop, function(prop, oldVal, newVal){ array.push(newVal); return oldVal })
		obj[prop] = oldVal
	}
	
}