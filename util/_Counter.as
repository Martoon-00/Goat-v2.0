import lang.*

class util._Counter {
	static var values = new Object()
	
	static var lol_ = new FuncInvoker(init)
	
	static function init(){
		_global.Counter = {
			__resolve: function(name: String){
				var ref = Optional.ofObj(_Counter.values, name)
				ref.orElse(-1)
				
				ref.value = (ref.value + 1) % 1e10
				return ref.value
			}
		}
	}
	
}