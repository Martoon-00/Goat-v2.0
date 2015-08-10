class lang.Reference {
	private var obj: Object
	private var prop: String
	
	private var invoke: Function
	
	function Reference(obj: Object, prop: String) {
		this.obj = obj
		this.prop = prop
		
		invoke = function(){ return obj[prop].apply(obj, arguments) }
		
		addProperty("value", this.get, this.set)
	}
	
	private var lastVal: Object
	private var lastRes: Object
	
	function get(): Object {
		if (lastVal === obj[prop]) return lastRes
		
		if (typeof(obj[prop]) == "function") {
			lastRes = invoke
		} else {
			lastRes = obj[prop]
		}
		
		return lastRes
	}
	
	function set(value: Object): Void {
		obj[prop] = value
	}
}