import geom.*
import coordinates.*
import lang.*

class geom.Circle extends Shape {
	var S: Coord
	var R: Number
	
	function Circle(S: Coord, R: Number) {
		this.S = S
		this.R = R
	}
	
	function move(vector: Coord): Circle { S = S.plus(vector); return this }
	
	function maxDistance(point: Coord): Number { return S.minus(point).dist() + R }
	
	function draw(dr: Drawer): Void { 
		dr.modify(Transform.MOVE(S.x, S.y)).circle(R)
	}
	
	function getCenter(): Coord { return S }
	
	function toString(): String { return Strings.format("Circle S = %s, R = %s", S, R) }
}