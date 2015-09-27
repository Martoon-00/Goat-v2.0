import lang.*

class lang.Range {
	static var EMPTY = new Range(Number.NEGATIVE_INFINITY, Number.NEGATIVE_INFINITY)
	static var POINT = new Range(0, 0)
	static var UNIT = new Range(0, 1)
	static var DIUNIT = new Range(-1, 1)
	static var RAY = new Range(0, Number.POSITIVE_INFINITY)
	static var LINE = new Range(Number.NEGATIVE_INFINITY, Number.POSITIVE_INFINITY)
	
	var a: Number
	var b: Number
	
	function Range(a: Number, b: Number) {
		this.a = a
		this.b = b
	}
	
	
	function isEmpty(): Boolean { return a == b && Math.abs(a) == Number.POSITIVE_INFINITY }
	
	function bound(k: Number) {	return Math.min(b, Math.max(a, k)) }
	function includes(k: Number) { return a <= k && b >= k }
	
	function norm(): Range { if (b < a) {a += b; b = a - b; a -= b}; return this }
	private function check(): Range { return a <= b ? this : EMPTY }
	function plus(k: Number): Range { return new Range(a + k, b + k) }
	function minus(k: Number): Range { return new Range(a - k, b - k) }
	function timesFixed(k: Number): Range { return new Range(a * k, b * k) }
	function times(k: Number): Range { return new Range(a * k, b * k).norm() }
	function sqrt(): Range {
		var r = intersect(RAY)
		return r.isEmpty() ? r : new Range(Math.sqrt(r.a), Math.sqrt(r.b))
	}
	function add(r: Range): Range { return new Range(Math.min(a, b) + Math.min(r.a, r.b), Math.max(a, b) + Math.max(r.a, r.b)) }
	function sub(r: Range): Range { return add(r.times(-1)) }
	function sqr(r: Range): Range { return a * b >= 0 ? new Range(a * a, b * b).norm() : new Range(0, Math.max(a * a, b * b)) }
	
	function intersect(other: Range) { return new Range(Math.max(a, other.a), Math.min(b, other.b)).check() }
	
	function iterate(f: Function): Void { 
		if (isNaN(a / 1) || isNaN(b / 1)) throw new Error("Range.iterate accepted broken coordinates")
		if (b > a) {
			var q = Math.floor(a)
			var w = Math.ceil(b)
			for (var i = q; i <= w; i++) f(i) 
		}
		else { 
			var q = Math.ceil(a)
			var w = Math.floor(b)
			for (var i = q; i >= w; i--) f(i) 
		}
	}
	
	function toString(): String { return Strings.format("[%s; %s]", a, b) }
	
}