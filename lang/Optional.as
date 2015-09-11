class lang.Optional {
	private var obj: Object
	private var name: String
	
	private function Optional(obj: Object, name: String) {
		this.obj = obj
		this.name = name
		
		addProperty("value", function(){ return obj[name] }, function(v){ obj[name] = v })
	}
	
	static function of(value){
		return new Optional({value: value}, "value")
	}
	
	static function ofObj(obj: Object, name: String) {
		return new Optional(obj, name)
	}
	
	function map(other: Object): Object {
		var mapper = arguments[arguments.length - 1]
		return obj[name] = (obj[name] == null ? other : mapper.apply(null, new Array().concat(obj[name]).concat(arguments.slice(1, -1))))
	}
	
	function orElse(other: Object): Object {
		return obj[name] = (obj[name] == null ? other : obj[name])
	}
}