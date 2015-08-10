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
		
		watch("x", function(){ return arguments[1] })
		watch("y", function(){ return arguments[1] })
	}
	function plus(c:Coord):Coord {
		return new Coord(x + c.x, y + c.y);
	}
	function minus(c:Coord):Coord {
		return new Coord(x - c.x, y - c.y);
	}
	function times(k:Number):Coord {
		return new Coord(x * k, y * k);
	}
	function turn(k:Number):Coord {
		return new Coord(x * Math.cos(k) + -y * Math.sin(k), x * Math.sin(k) + y * Math.cos(k))
	}
	function rotate(k:Number):Coord {
		return turn(k * Math.PI / 180)
	}
	function dist():Number {
		return Math.sqrt(x * x + y * y)
	}
	function ort():Coord {
		return this.times(1 / dist())
	}
	function angle():Number {
		return Math.atan2(y, x)
	}
	function rotation():Number {
		return angle() / Math.PI * 180
	}
	function assign(o:Object):Void {
		o._x = x;
		o._y = y;
	}
	function toString():String {
		return "(" + x + ", " + y + ")";
	}
	function isBroken():Boolean{
		return isNaN(x / 1) || isNaN(y / 1)
	}
	
	function random(maxX: Number, maxY: Number): Coord {
		if (maxY == undefined) maxY = maxX
		return new Coord(random(maxX), random(maxY))
	}
}