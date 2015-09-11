import geom.*
import coordinates.*
import lang.*

class geom.Shape {
	function move(vector: Coord): Shape { 
		throw new Error("No move defined for " + this)
		return null
	}
	
	function maxDistance(point: Coord): Number {
		throw new Error("No maxDistance defined for " + this)
		return null
	}
	
	function draw(dr: Drawer): Void {
		throw new Error("No draw defined for " + this)
	}
	
	function getCenter(): Coord {
		throw new Error("No draw defined for " + this)
		return null
	}
}