import geom.*
import coordinates.*

class geom.Hitbox {
	private static var boxes = {
		__resolve: function(name: String){ return new Array() }
	}
	
	private var category: String
	private var index: Number
	
	private var parts: Array
	private var exclude: Shape
	
	function Hitbox(category: String, parts: Array, exclude: Shape) {
		this.category = category
		this.parts = parts
		this.exclude = exclude
		
		index = boxes[category].push(this) - 1
	}
	
	function intersect(other: Hitbox): Intersection {
		return null
	}
	
	function destroy(): Void {
		if (index == -1) trace("Hitbox destroyed again!")
		delete boxes[category][index]
		index = -1
	}
	
}