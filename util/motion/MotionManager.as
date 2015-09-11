import util.motion.*
import coordinates.*

interface MotionManager {
	function step(start: Coord, dest: Coord): Coord
	
}