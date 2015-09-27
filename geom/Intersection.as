import geom.*
import coordinates.*
import lang.*

class geom.Intersection {
	private var time: Number
	
	private function Intersection(time: Number) {
		this.time = time
	}
	
	function toString(): String { return Strings.format("[Intersection: time = %s]", time) }
	
	static function of(shape1: Shape, shape2: Shape, v1: Coord, v2: Coord): Number { 
		if (v1 == undefined) v1 = Coord.ZERO
		if (v2 == undefined) v2 = Coord.ZERO
		
		if (shape1 instanceof Line && shape2 instanceof Line) {
			var s1 = Line(shape1)
			var s2 = Line(shape2)
			
			var dv = v2.minus(v1)
			var dS = s2.S.minus(s1.S)
			var pn1 = s1.p.normal()
			var pn2 = s2.p.normal()
			
			var r1 = solveLinear(-dv.scalar(pn1), s1.p.scalar(pn2), Range.UNIT, dS.scalar(pn2))
			var r2 = solveLinear(dv.scalar(pn2), s2.p.scalar(pn1), Range.UNIT, -dS.scalar(pn1))
			var r = Range.UNIT.intersect(r1).intersect(r2)
			
			var t = r.isEmpty() ? 1 : r.a
			
			return t
		} else if (shape1 instanceof Line && shape2 instanceof Circle) { 
			var s1 = Line(shape1)
			var s2 = Circle(shape2)
			
			var dS = s2.S.minus(s1.S)
			var dv = v2.minus(v1)
			
			var pn = s1.p.normal()
			var r1: Range = solveLinear(-pn.scalar(dv), pn.dist() * s2.R, Range.DIUNIT, pn.scalar(dS))
			
			var b = s1.r.times(dv.scalar(s1.p)).minus(dv.scalar(dS))
			var vec_prod = s1.r.times(s1.p.x * dv.y - s1.p.y * dv.x).minus(dS.vector(dv))
			var q = vec_prod.sqr().times(-1).plus(dv.times(s2.R).sqr()).minus(1e-8).sqrt()
			var r2_1: Range = solveLinear(dv.sqr(), 1, b.sub(q), 0)
			var r2_2: Range = solveLinear(dv.sqr(), 1, b.add(q), 0)
			
			var m: Range = r1.intersect(Range.UNIT)
			var m1: Range = m.intersect(r2_1)
			var m2: Range = m.intersect(r2_2)
			
			var t = 1
			if (!m1.isEmpty() && m1.b >= 1e-5) t = Math.min(t, m1.a)
			if (!m2.isEmpty() && m2.b >= 1e-5) t = Math.min(t, m2.a)
			
			return t
		} else if (shape1 instanceof Circle && shape2 instanceof Line) {
			return of(shape2, shape1, v2, v1)
		} else if (shape1 instanceof Circle && shape2 instanceof Circle) {
			var s1 = Circle(shape1)
			var s2 = Circle(shape2)
			return of(new Line(s1.S, new Coord(1, 0), Range.POINT), new Circle(s2.S, s1.R + s2.R))
		} else {
			throw new Error(Strings.format("Such shape combination cannot be processed:\n%s\n%s", shape1, shape2))
		}
		
	}
	
	/** solves a * x = b * y + c
	* x - variable (interval)
	* y - parameter (interval)
	*/
	static function solveLinear(a: Number, b: Number, y: Range, c: Number): Range { 
		var r: Range = y.times(b).plus(c)
		if (a == 0) {
			return r.includes(0) ? Range.LINE : Range.EMPTY
		} else {
			return r.times(1 / a)
		}
	}
	
	
	static function resistance(shape1: Shape, shape2: Shape): Coord {
		if (shape1 instanceof Circle && shape2 instanceof Line) {
			var s1 = Circle(shape1)
			var s2 = Line(shape2)
			
			var dS = s1.S.minus(s2.S)
			
			var r1 = dS.minus(s2.p.times(s2.r.a))
			if (r1.dist() <= s1.R + 1e-5) return r1
			var r2 = dS.minus(s2.p.times(s2.r.b))
			if (r2.dist() <= s1.R + 1e-5) return r2
			
			var n = s2.p.normal()
			return dS.vector(s2.p) >= 0 ? n.neg() : n
		} else if (shape2 instanceof Circle && shape1 instanceof Circle) {
			var s1 = shape1
			var s2 = shape2
			return s1.S.minus(s2.S)
		} else throw new Error(Strings.format("[Intersection.resistance] Such shape combination cannot be processed:\n%s\n%s", shape1, shape2))
	}
	
}