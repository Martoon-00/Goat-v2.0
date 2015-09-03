import lang.*
import coordinates.*

class lang.Drawer {
	private var mc: MovieClip
	private var trans: Transform 
	
	function Drawer(mc: MovieClip) {
		this.mc = mc
		trans = Transform.E
	}
	
	function transform(t: Transform): Drawer {
		trans = t == undefined ? Transform.E : t
		return this
	}
	
	function moveTo(): Drawer { 
		var coord = new Coord(arguments)
		mc.moveTo.call(mc, trans.applyX(coord.x, coord.y), trans.applyY(coord.x, coord.y)) 
		return this
	}
	function lineTo(): Drawer { 
		var coord = new Coord(arguments)
		mc.lineTo.call(mc, trans.applyX(coord.x, coord.y), trans.applyY(coord.x, coord.y))
		return this
	}
	function curveTo(x1: Number, y1: Number, x2: Number, y2: Number): Drawer { 
		mc.curveTo.call(mc, trans.applyX(x1, y1), trans.applyY(x1, y1), trans.applyX(x2, y2), trans.applyY(x2, y2)) 
		return this
	}
	function lineStyle(): Drawer { mc.lineStyle.apply(mc, arguments); return this }
	function clear(): Drawer { mc.clear.apply(mc, arguments); return this }
	function beginFill(): Drawer { mc.beginFill.apply(mc, arguments); return this }
	function beginGradientFill(): Drawer { mc.beginGradientFill.apply(mc, arguments); return this }
	function endFill(): Drawer { mc.endFill.apply(mc, arguments); return this }
	
	function getMovieClip(): MovieClip { return mc }
	
	function rectangle(x1: Number, x2: Number, y1: Number, y2: Number): Drawer { 
		moveTo(x1, y1)
		lineTo(x1, y2)
		lineTo(x2, y2)
		lineTo(x2, y1)
		lineTo(x1, y1)
		return this
	}
	
	function square(x: Number, y: Number, size: Number): Drawer { 
		if (arguments.length == 1) { x = 0; y = 0; size = arguments[0] }
		return rectangle(x - size, x + size, y - size, y + size)
	}
	
	function perfectPoly(n: Number, size: Number, endAngle: Number, startAngle: Number): Drawer { 
		if (endAngle == undefined) endAngle = 2 * Math.PI - 1e-5
		if (startAngle == undefined) startAngle = 0
		
		endAngle = Angle.ofRad(endAngle).upTo(Angle.ofRad(startAngle)).radian
		var sector = 2 * Math.PI / n
		var outsize = size / Math.cos(sector / 2)
		
		var i = Math.floor(startAngle / sector)
		moveTo(Coord.ZERO)
		lineTo(new Coord(size / Math.cos(Math.abs(startAngle - (i + 0.5) * sector)), 0).turn(startAngle))
		
		for (; ; i++){
			var newAngle = sector * (i + 1) 
			
			if (newAngle >= endAngle){ 
				lineTo(new Coord(size / Math.cos(Math.abs(endAngle - (i + 0.5) * sector)), 0).turn(endAngle))
				break
			}
			else {
				lineTo(new Coord(outsize, 0).turn(newAngle))
			}
		}
		return this
	}
	
	function circle(r: Number): Drawer { 
	    moveTo(r, 0);
	    curveTo(r, Math.tan(Math.PI/8)*r, Math.sin(Math.PI/4)*r, Math.sin(Math.PI/4)*r);
	    curveTo(Math.tan(Math.PI/8)*r, r, 0, r);
 	   	curveTo(-Math.tan(Math.PI/8)*r, r, -Math.sin(Math.PI/4)*r, Math.sin(Math.PI/4)*r);
    	curveTo(-r, Math.tan(Math.PI/8)*r, -r, 0);
    	curveTo(-r, -Math.tan(Math.PI/8)*r, -Math.sin(Math.PI/4)*r, -Math.sin(Math.PI/4)*r);
	    curveTo(-Math.tan(Math.PI/8)*r, -r, 0, -r);
	    curveTo(Math.tan(Math.PI/8)*r, -r, Math.sin(Math.PI/4)*r, -Math.sin(Math.PI/4)*r);
	    curveTo(r, -Math.tan(Math.PI/8)*r, r, 0);
		return this	
	}
}