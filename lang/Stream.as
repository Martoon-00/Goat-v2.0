class lang.Stream {
	private var values:Array
	
	function Stream(values:Array){ this.values = values }
	
	static function of(): Stream { return new Stream(arguments) }
	
	static function ofObj(obj: Object): Stream {
		var a = new Array()
		lang.Objects.iterate(obj, function(name, value){ a.push(value) })
		return new Stream(a)
	}
	
	function forEach(action:Function): Stream { // for each value invoke f(this = value)
		for (var i = 0; i < values.length; i++)
			action.call(values[i])
		return this
	}
	
	function forEachArg(action:Function): Stream {
		for (var i = 0; i < values.length; i++)
			action.call(null, values[i])
		return this
	}
	
	function collect(initValue, appender:Function){ // equals to call appender(this = appender(this = initValue, value1), value2...)
		forEach(function(){ initValue = appender.call(initValue, this) })
		return initValue
	}
	
	function filter(predicate:Function):Stream { // remains only values: predicate(this = value) == true
		return new Stream(collect(
			new Array(), 
			function(value){
				if (predicate.call(value)) 
					this.push(value)
				return this 
			}
		))
	}
	
	function map(mapper:Function):Stream { // apples mapper to each value
		var newValues = new Array()
		forEach(function(){ newValues.push(mapper.call(this)) })
		return new Stream(newValues)
	}
	
	function min(): Stream {
		return collect(Number.POSITIVE_INFINITY, function(v: Number){ return Math.min(this, v) })
	}
	function max(): Stream {
		return collect(Number.NEGATIVE_INFINITY, function(v: Number){ return Math.max(this, v) })
	}
	
	function toArray():Array {
		return collect(new Array(), Array(null).concat);
	}
	
	function count(): Number {
		return values.length
	}
	
	static function generate(num:Number, generator:Function):Stream {
		return new Stream(new Array(num)).map(generator)
	}
	
	
	
	static function CALL(f: Function) {
		return f()
	}
}