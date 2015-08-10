class lang.Listener {
	private var listeners: Array
	
	function Listener() {
		listeners = new Array()
	}
	
	function register(f: Function): Function {
		var _this = this
		var pos = listeners.push(f) - 1
		return function(){ delete _this.listeners[pos] }		
	}
	
	function invoke(){ 
		for (var i in listeners){ 
			listeners[i].apply(null, arguments)
		}
	}
	
}