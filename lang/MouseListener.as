import lang.*

class lang.MouseListener {
	static var availableListeners = [
		"onPress",
		"onRelease",
		"onHold"
	]
	
	var onPress: Object
	var onRelease: Object
	var onHold: Object
	
	var listeners: Array
	
	private var pressed = false
	
	private var turned = true
	
	function MouseListener(mc: MovieClip){
		var _this = this
		listeners = new Array()
		globals.Timing.addEnterFrame(function(){ _this.enterFrame() })
		
		new Stream(availableListeners).forEachArg(function(liName){ 
			_this.watch(liName, function(prop, oldVal, newVal){ 
				var li = new Object()
				li[prop] = newVal
				listeners.push(li) 
				return oldVal 
			})					  
		})
		
		watch("pressed", function(prop, oldVal, newVal){ 
			if (oldVal != newVal && _this.turned){ 
				invoke(newVal ? "onPress" : "onRelease")
			}
			return newVal
		})
		
		if (mc == undefined) {
			Mouse.addListener({
				onMouseDown: function(){ _this.pressed = true },
				onMouseUp: function(){ _this.pressed = false }				  
			})
		} else { 
			mc.onPress = function(){ _this.pressed = true },
			mc.onRelease = function(){ _this.pressed = false }
			mc.onReleaseOutside = function(){ _this.pressed = false }
		}
			
	}
	
	function register(listener: Object): Function {
		var _this = this
		var index = listeners.push(listener) - 1
		return function(){ delete _this.listeners[index] }
	}
	
	function turn(state: Boolean): MouseListener {
		turned = state
		return this
	}
	
	private function invoke(liName: String) { 
		for (var i in listeners) listeners[i][liName]()
	}
	
	private function enterFrame(): Void { 
		if (!turned) return; 
		
		if (pressed){ 
			invoke("onHold")
		}
	}
	
}