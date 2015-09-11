import geom.*
import coordinates.*
import phys.*
import lang.*
import phys.*

class geom.Hitbox {
	private static var debug = true
	
	private static var boxes = {
		__resolve: function(name: String){ return new Array() }
	}
	
	var category: String
	private var index: Number
	
	private var parts: Array
	private var size: Number
	
	var mc: Material
	private var posGetter: Function
	private var lastPos: Coord
	
	function Hitbox(category: String, pos) {   
		this.category = category
		this.parts = arguments.slice(2)
		this.size = 0
		
		if (pos instanceof Material){ 
			posGetter = function(){ return Material(pos)._pos }
			mc = Material(pos)
		}
		else if (pos instanceof Function) posGetter = pos
		else if (pos instanceof Coord) posGetter = function(){ return pos }
		else throw new Error("[Hitbox#<init>] Unexpected type of 2nd parameter: " + pos)
		
		for (var i in parts) size = Math.max(size, parts[i].maxDistance(Coord.ZERO))
		_global._field.meshKeeper.register(this)
		
		index = boxes[category].push(this) - 1
		
		lastPos = Coord.ZERO
		checkPos()
	}
	
	static function boxOf(category: String, pos, x1: Number, x2: Number, y1: Number, y2: Number): Hitbox {
		return new Hitbox(category, pos,
			new Line(new Coord(x1, y1), new Coord(x2 - x1, 0), Range.UNIT),
			new Line(new Coord(x2, y1), new Coord(0, y2 - y1), Range.UNIT),
			new Line(new Coord(x2, y2), new Coord(x1 - x2, 0), Range.UNIT),
			new Line(new Coord(x1, y2), new Coord(0, y1 - y2), Range.UNIT)
		)
	}
	
	function intersect(other: Hitbox, move: Coord) { 
		var _parts = other.parts
		
		checkPos()
		other.checkPos()
		
		if (lastPos.minus(other.lastPos).dist() > move.dist() + size + other.size)
			return { t: 1, n: null }
		
		if (debug) {
			var debug_mc = MovieClips.createUniqueMovieClip(_global._field.hitboxes, 0)
			new Drawer(debug_mc)
				.lineStyle(3, 0xFF0000)
				.moveTo(lastPos).lineTo(other.lastPos)
			debug_mc.onEnterFrame = function(){
				if (this._alpha -= 10 <= 0) {
					this.removeMovieClip(this)
				}
			}
		}
		
		var t: Number = 1
		var _i: Number, _j: Number
		for (var i in parts) {
			var part = parts[i]
			for (var j in _parts) { 
				var r = Intersection.of(part, _parts[j], move)
				if (r < t) { 
					t = r
					_i = i
					_j = j
				}
			}
		}
		
		if (_i != undefined) { 
			var n = Intersection.resistance(parts[_i], _parts[_j])
		}
		
		return { t: t, n: n }
	}
	
	function checkPos(): Void {  // moves shapes if linked movie has moved
		var pos = posGetter()
		if (!lastPos.equals(pos)) { 
			var delta = pos.minus(lastPos)
			for (var i in parts) { 
				parts[i].move(delta)
			}
				
			_global._field.meshKeeper.move(this, lastPos, pos)
			
			lastPos = pos
		}
	}
	
	function destroy(): Void {
		if (index == -1) 
			trace("Hitbox destroyed again!")
		else {
			delete boxes[category][index]
			index = -1
		}
	}
	
	function toString(): String { return Strings.format("[Hitbox \"%s\" \n%s\n]", category, parts.join()) }
	
}