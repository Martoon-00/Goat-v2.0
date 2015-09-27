import geom.*
import coordinates.*
import phys.*
import lang.*
import phys.*

class geom.Hitbox {
	private static var debug = 0
	
	private static var _lol = new FuncInvoker(init)
	private static var boxes: Object
	private static function init() {
		boxes = {
			__resolve: function(name: String) {
				return this[name] = new Array()
			}
		}
	}
	
	var category: String
	private var index: Number
	
	private var parts: Array
	private var size: Number
	
	private var material: Material
	private var lastPos: Coord
	
	private var unregFromMesh: Function
	
	function Hitbox(category: String) {    
		this.category = category
		index = boxes[category].push(this) - 1
		
		this.parts = arguments.slice(2)
		size = new Stream(parts)
			.map(function(){ return this.maxDistance(Coord.ZERO) })
			.max()
		
		unregFromMesh = _global._field.meshKeeper.register(this)
		
		lastPos = Coord.ZERO  // in checkPos all shapes will be moved from their initial ZERO position to current one
	}
	
	function setMaterial(material: Material): Hitbox {
		this.material = material
		return this
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
		var pos = material._pos
		if (!lastPos.equals(pos)) { 
			var delta = pos.minus(lastPos)
			for (var i in parts) { 
				parts[i].move(delta)
			}
			
			unregFromMesh = _global._field.meshKeeper.move(this, lastPos, pos, unregFromMesh)
			
			lastPos = pos
		}
		
		if (debug) { 
			var name = "hitbox_" + category + "_" + index
			var debug_mc = _global._field.hitboxes[name]
			if (debug_mc == null) debug_mc = MovieClips.createEmptyMovieClip(_global._field.hitboxes, name, 0)
			var dr = new Drawer(debug_mc)
				.clear()
				.lineStyle(3, 0xFF0000)
				.beginFill(0xA0FFFF)
			for (i in parts) parts[i].draw(dr)
		}
	}
	
	function destroy(): Void {  
		if (index == -1) 
			trace("Hitbox destroyed again!")
		else {
			delete boxes[category][index]
			index = -1
			
			unregFromMesh()
		}
	}
	
	function toString(): String { return Strings.format("[Hitbox \"%s\" \n%s\n]", category, parts.join()) }
	
}