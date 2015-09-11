import geom.*
import coordinates.*
import lang.*

class geom.Line extends Shape {
	var S: Coord
	var p: Coord
	
	var r: Range
	
	function Line(S: Coord, p: Coord, r: Range) {
		this.S = S
		this.p = p
		this.r = Optional.of(r).orElse(Range.UNIT)
	}
	
	static function fromEnds(A: Coord, B: Coord, r: Range): Line {
		return new Line(A, B.minus(A), r)
	}
	
	function move(vector: Coord): Line { S = S.plus(vector); return this }
	
	function maxDistance(point: Coord): Number { 
		var d = S.minus(point)
		return Math.max(d.dist(), d.plus(p).dist())
	}
	
	function draw(dr: Drawer): Void {
		dr.modify(Transform.MOVE(S.x, S.y)).moveTo(p.times(r.a)).lineTo(p.times(r.b))
	}
	
	function getCenter(): Coord { return S }
	
	function toString(): String { return Strings.format("Line S = %s, p = %s, r = %s", S, p, r) }
}