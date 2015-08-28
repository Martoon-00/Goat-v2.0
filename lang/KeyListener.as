import lang.*
import globals.*

class lang.KeyListener {
	private static var listeners: Object

	private static var _lol = new FuncInvoker(init)
	
	static function init() { 
		listeners = {
			__resolve: function(name: String){ return listeners[name] = new Array() }
		}
		Timing.addEnterFrame(checkKeys);
	}
	
	private static function checkKeys() {
		for (var key in listeners){ 
		var pressed = Key.isDown(key)
			for (var i = 0; i < listeners[key].length; i++){
				var listener = listeners[key][i]
				listener.held = pressed
				if (pressed) {
					listener.onHold()
				}
				listener.onEnterFrame(pressed)
			}
		}
	}
	
	static function register(code:Number, listener:Object): Function {
		listener = Objects.createCopy(listener)
		var index = listeners[regulateCode(code)].push(listener) - 1
		
		listener.held = false
		listener.watch("held", function(name, oldVal, newVal){ 
			if (oldVal != newVal) {
				if (newVal) this.onPress()
				else this.onRelease()
			}
			return newVal
		})
		
		return Functions.makeExecOnce(function(){ listeners[regulateCode(code)].splice(index, 1) })
	}
	
	private static function regulateCode(code: Number): Number { 
		return String.fromCharCode(code).toUpperCase().charCodeAt(0)
	}
	
	static function createListenerFunction(code:Number, f:Function):Function { // returns function which invokes f(was key recently pressed)
		var pressed = false
		var args = arguments
		register(code, function(){ pressed = true })
		return function(){ 
			var res = f.apply(null, new Array().concat(pressed).concat(args.slice(2))) 
			pressed = false 
			return res
		}
	}
}