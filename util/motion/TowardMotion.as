import util.motion
import coordinates.*

class util.Motion.TowardMotion implements MotionManager {
	function step(start: Coord, dest: Coord): Coord {
		var d = dest.minus(start)
		var f = Math.max(0, stepToward(d.length))
		return start.plus(d.times(f / d))
	}
	
	function stepToward(dist: Number): Number {
		throw new Error("No TowardMotion.stepToward specified!")
		return 0
	}
}