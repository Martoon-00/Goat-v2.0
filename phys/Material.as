import lang.*
import coordinates.*
import labirinth.*
import phys.*

class phys.Material extends MovieClipBase {
	var lab: Labirinth  // will be init by labirinth when created by it
	var moving: MoveController
		
	function Material() {
		moving = new MoveController(this)
	}
		
	function init(lab: Labirinth): Void {
		this.lab = lab
	}
	
	function getCoord(): Coord {
		return new Coord(this)
	}
	
	function move(vector: Coord){
		var oldPos = getCoord()
		oldPos.plus(vector).assign(this)
		if (vector.dist() > 0) moving.onMove.invoke(oldPos, new Coord(this))
		_rotation = vector.angle() / Math.PI * 180 + 90
	}
	
	function atCollision(collisionPoint: Coord){
		collisionPoint.assign(this)
	}
	
}