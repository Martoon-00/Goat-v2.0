import labirinth.*
import lang.*

class labirinth.DirectionSet {
	private var ids:Number
	
	static var EMPTY = new DirectionSet(0)
	
	private function DirectionSet(ids:Number){ this.ids = ids }
	
	static function of():DirectionSet {
		return new Stream(arguments).collect(
			EMPTY, 
			EMPTY.add  // extracting non-static method
		)
	}
	
	function inverse():DirectionSet {
		return new DirectionSet(15 - ids)
	}
	
	function contains(dir: Direction):Boolean {
		return Boolean(dir.id & ids)
	}
	
	function add(dir: Direction):DirectionSet {
		return new DirectionSet(ids | dir.id)
	}
	
	function equals(other: DirectionSet):Boolean {
		return ids == other.ids
	}
	
	function size():Number {
		return toArray().length
	}
	
	static function valueOf(s: String):DirectionSet {
		s = s.toUpperCase()
		return new Stream(Direction.values())
			.filter(function(){ return s.indexOf(toString()) != -1 })
			.collect(
				EMPTY, 
				EMPTY.add  // extracting non-static method 
			)
	}
	
	function toString():String {
		var ids = this.ids
		return new Stream(toArray()).collect(
			"", 
			String(null).concat  // extracting non-static method 
		)
	}
	
	function toArray():Array {
		var this_obj = this
		return new Stream(Direction.values())
			.filter(function(){ return this_obj.contains(this) })
			.toArray()
		}
}