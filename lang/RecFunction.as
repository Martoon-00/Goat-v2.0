class lang.RecFunction {
	private var this_obj:Object
	private var wrapper:Function
	
	function RecFunction(f:Function){
		this_obj = null
		
		var this_ = this
		wrapper = function(){
			return f.apply(this_obj, new Array().concat(this_.wrapper).concat(arguments))
		}
	}
	
	function withThis(this_obj:Object):RecFunction {
		this.this_obj = this_obj
		return this
	}
	
	function build():Function {
		return wrapper
	}
	
	function addWrapper(wrapperBuilder:Function):RecFunction {
		var ctx = new Object()
		wrapper = ctx.wrapper = wrapperBuilder(wrapper)
		return this
	}
	
	function caching(): RecFunction {
		var this_obj_ = this_obj
		return addWrapper(function(oldWrapper:Function){ 
			var cache = new Object()
			return function(){ 
				var key = new Array().concat(this_obj_).concat(arguments).join("¤")
				if (cache[key] != undefined) return cache[key]
				return cache[key] = oldWrapper.apply(null, arguments) 
			} 
		})
	}
	
	function logging(logger: Function): RecFunction {
		if (logger == undefined) logger = function(_this, args, res){ trace("[" + _this + "] " + args.join() + " -> " + res) }
		var this_obj_ = this_obj
		return addWrapper(function(oldWrapper:Function){ 
			return function(){ 
				var res = oldWrapper.apply(null, arguments) 
				logger(this_obj_, arguments, res)
				return res
			} 
		})
	}
	
	function debug(logger: Function): RecFunction {
		if (logger == undefined) logger = function(_this, args){ trace("[" + _this + "] " + args.join()) }
		var this_obj_ = this_obj
		return addWrapper(function(oldWrapper:Function){ 
			return function(){ 
				logger(this_obj_, arguments)
				var res = oldWrapper.apply(null, arguments) 
				return res
			} 
		})
	}
	
	function avoidLoops(onLooped: Function): RecFunction {
		if (onLooped == undefined) onLooped = function(this_obj, args: Array){ throw new Error(lang.Strings.format("Loop!: [%s]", args)) }
		var this_obj_ = this_obj
		return addWrapper(function(oldWrapper: Function) {
			var was = new Object()
			return function() {
				var key = new Array().concat(this_obj_).concat(arguments).join("¤")
				if (was[key] != undefined) onLooped(this_obj_, arguments)
				was[key] = new Object()
				return oldWrapper.apply(null, arguments)
			}	
		})
		
	}
}