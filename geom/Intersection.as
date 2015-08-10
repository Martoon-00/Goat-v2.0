import geom.*
import coordinates.*
import lang.*

class geom.Intersection {
	static var NONE = 0
	static var PART = 1
	static var CONTAIN = 2
	static var PART_OF = 3
	
	private static var TYPE_NAMES = ["no", "partially", "contains"]
	
	private static var shortcuts = ["circ"]
	
	var type: Number
	
	function Intersection(type: Number) {
		this.type = type
	}
	
	static function of(a: Shape, b: Shape): Intersection {
		var ta = getType(a)
		var tb = getType(b)
		return a <= b 
			? Intersection[shortcuts[ta] + "_" + shortcuts[tb]].call(null, a, b)
			: Intersection[shortcuts[tb] + "_" + shortcuts[ta]].call(null, b, a).reverse()
	}
	
	private static function getType(s: Shape): Number {
		var shapes = [Circle]
		for (var i in shapes) {
			if (s instanceof shapes[i]) return i
		}
		trace("No such type")
	}
	
	function reverse(): Intersection { 
		var newType = type == NONE || PART ? type : CONTAIN + PART_OF - type
		return new Intersection(newType)
	}
	
	static function circ_circ(a: Circle, b: Circle): Intersection {
		var d = a.O.minus(b.O).dist()
		var type = 
			  d <= a.R - b.R ? CONTAIN 
			: d <= a.R + b.R ? PART
			: d <= b.R - a.R ? PART_OF
			:				   NONE
			
		return new Intersection(type)
	}
	
	function toString(): String { 
		return Strings.format("Intersection %s", TYPE_NAMES[type]) 
	}
}