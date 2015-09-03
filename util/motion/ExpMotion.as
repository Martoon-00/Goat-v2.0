import util.motion.*
import coordinates.*

class ExpManager implements MotionManager {
	private var coef: Number
	
	function MotionManager(coef: Number) {
		this.coef = coef
	}
	
	function step(start: Coord, dest: Coord): Coord {
		return start.times(1 - coef).plus(dest.times(coef))
	}
}