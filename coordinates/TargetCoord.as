import phys.*
import coordinates.*

class coordinates.TargetCoord {
	private var target: Material
	private var coord: Function
	
	private function TargetCoord(target: Material, coord: Function){
		this.target = target
		this.coord = coord
	}
	
	static function ofTarget(target: Material){
		return new TargetCoord(target, target.getCoord)
	}
	
	static function ofCoord(coord: Coord){
		return new TargetCoord(null, function(){ return coord })
	}
	
	function getTarget(): Material { return target }
	
	function getCoord(): Coord { return coord.call(target) }
	
	function fixed(): TargetCoord {
		return ofCoord(getCoord())
	}
}