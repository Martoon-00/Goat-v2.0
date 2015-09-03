import util.motion.*
import coordinates.*

class ImmediateMotion implements MotionManager {
	function step(start: Coord, dest: Coord): Coord { 
		return dest 
	}
}