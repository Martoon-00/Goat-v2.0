import geom.*
import coordinates.*
import lang.*

class geom.Circle extends Shape {
	var O: Coord
	var R: Number
	
	function Circle(O: Coord, R: Number) {
		this.O = O
		this.R = R
	}
	
	function move(vector: Coord): Circle {
		O = vector.plus(O)
		return this
	}
	
	function toString(): String { return Strings.format("Circle O = %s, R = %s", O, R) }
}