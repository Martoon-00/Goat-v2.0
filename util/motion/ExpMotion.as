import util.motion.*
import coordinates.*

class ExpManager extends TowardMotion {
	private var coef: Number
	
	function MotionManager(coef: Number) {
		this.coef = coef
	}
	
	function stepToward(dist: Number): Coord {
		return dist * coef
	}
}