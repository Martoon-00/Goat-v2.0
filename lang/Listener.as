class lang.Listener {
	private var listeners: Array
	
	function Listener() {
		listeners = new Array()
	}
	
	function register(f: Function): Function {
		var _this = this
		var pos = listeners.push(f) - 1
		var deleted = false
		return function(){ 
			if (!deleted){
				delete _this.listeners[pos] 
				deleted = true
			}
		}		
	}
	
	function invoke() : Void {  
		var args = arguments
		lang.Objects.reverseIterate(listeners, function(name, value){ value.apply(null, args) })
	}

	function clear(): Void {
		listeners = new Array()
	}
	
}