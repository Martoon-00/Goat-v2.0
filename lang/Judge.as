import lang.*

class lang.Judge {
	static var ALWAYS_FALSE = function(){ return false }
	static var ALWAYS_TRUE = function(){ return true }
	static var BALANCED_BOOLEAN = function(){ return random(2) == 1 }
	
	static function random(k:Number): Function {  // retuns function, which returns true with k probability
		return function(){ return Math.random() < k }
	}
	
}