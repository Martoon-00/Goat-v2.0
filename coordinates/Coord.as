import lang.*

class coordinates.Coord {
	var x:Number;
	var y:Number;
	
	static var ZERO = new Coord(0, 0)
	
	function Coord() {
		if (arguments[0] instanceof Array) { 
			Function(Coord).apply(this, arguments[0])
		} else if (arguments[0] instanceof MovieClip) {
			x = arguments[0]._x;
			y = arguments[0]._y;
		} else if (arguments[0] instanceof Coord) { 
			x = arguments[0].x
			y = arguments[0].y
		} else { 
			x = arguments[0];
			y = arguments[1];
		}
	}
	
	function plus(c:Coord): Coord {
		return new Coord(x + c.x, y + c.y);
	}
	
	function minus(c:Coord): Coord {
		return new Coord(x - c.x, y - c.y);
	}
	
	function times(k:Number): Coord {
		return new Coord(x * k, y * k);
	}
	
	function turn(k:Number): Coord {
		return new Coord(x * Math.cos(k) + -y * Math.sin(k), x * Math.sin(k) + y * Math.cos(k))
	}
	
	function rotate(k:Number): Coord {
		return turn(k * Math.PI / 180)
	}
	
	function neg(): Coord { 
		return new Coord(-x, -y)
	}
	
	function sqr(): Number {
		return x * x + y * y
	}
	
	function dist(): Number {
		return Math.sqrt(x * x + y * y)
	}
	
	function ort(): Coord {
		return this.times(1 / dist())
	}
	
	function angle(): Number {
		return Math.atan2(y, x)
	}
	
	function rotation(): Number {
		return angle() / Math.PI * 180
	}
	
	function normal(): Coord {
		return new Coord(-y, x)
	}
	
	function scalar(other: Coord): Number {
		return x * other.x + y * other.y
	}
	
	function vector(other: Coord): Number {
		return x * other.y - y * other.x
	}
	
	function isCollinear(other: Coord): Boolean {
		return x * other.y == y * other.x
	}
	
	function boundLength(range: Range): Coord {
		var d: Number = dist()
		if (d == 0) trace("Coord.boundLength: this == (0, 0)!")
		return this.times(range.bound(d) / d)
	}
	
	function toString(): String {
		return "(" + x + ", " + y + ")";
	}
	
	function equals(other: Coord) {
		return x == other.x && y == other.y
	}
	
	function isBroken(): Boolean{
		return isNaN(x / 1) || isNaN(y / 1)
	}
	
	function random(maxX: Number, maxY: Number): Coord {
		if (maxY == undefined) maxY = maxX
		return new Coord(random(maxX), random(maxY))
	}
}