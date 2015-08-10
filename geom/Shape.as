import geom.*
import coordinates.*

class geom.Shape {
	function move(vector: Coord): Shape {
		trace("No move defined for this class (" + this + ")")
		return null
	}
	
	function intersect(other: Shape): Intersection {
		return Intersection.of(this, other)
	}
	
}