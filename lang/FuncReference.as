import lang.*

class lang.FuncReference {
	static var f = function(name: String){
		return new FuncReference(this["obj"], prop)
	}
	
	private var obj: Object
	private var prop: String
	
	function FuncReference(obj: Object, prop: String) { 
		this.obj = obj
		this.prop = prop
	}
	
	static function of(obj: Object) {
		return {
			__resolve: f,
			obj: obj
		}
	}
	
	function invoke() {
		return obj[prop]()
	}
}