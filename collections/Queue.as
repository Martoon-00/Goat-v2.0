import lang.*

class collections.Queue {
	private var stack1 = new Array()
	private var stack2 = new Array()
	
	function put(value: Object){
		stack1.push(value)
	}
	
	function get(){
		var e = take(stack2)
		if (e == null){
			stack2 = new Array()
			
			for (var i in stack1) {
				stack2.push(stack1[i])
				delete stack1[i]
			}
			stack1 = new Array()
			
			e = take(stack2)
		} 
		return e
	}
	
	
	private static function take(a: Array){
		for (var i in a) { 
			var v = a[i] 
			delete a[i]
			return v 
		}
		return null
	}
	
}