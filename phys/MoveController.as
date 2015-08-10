import lang.*
import creatures.*
import coordinates.*

class phys.MoveController {
	var onMove: Listener
	
	var speed = 5
	var target = null
	var owner: MovieClip
	
	var pointer: MovieClip
	
	function MoveController(owner: MovieClip) {
		var _this = this
		onMove = new Listener()
		this.owner = owner
		
		watch("target", function(prop, oldVal, newVal){
			if (newVal == null && oldVal != null) { 
				_this.pointer.onDestroy()
			} else if (newVal != null && oldVal == null) {
				_this.pointer = MovieClips.attachUniqueMovie(_global._field, "target_pointer", 100, { color: 0x0000FF })
			}
			
			if (newVal != null) {
				newVal.assign(_this.pointer)
			}
			return newVal
		})
		
		globals.Timing.addEnterFrame(function(){ _this.moveToTarget() })
	}
	
	function moveToTarget(){ 
		if (target != null) {
			if (owner.getCoord().minus(target).dist() < speed) {
				target = null
			} else {
				var collision = approach(target)
				if (collision) 
					target = null
			}
		}
	}
	
	private function approach(target: Coord){ 
		var path = target.minus(owner.getCoord())
		var delta = path.ort().times(Math.min(speed, path.dist()))
		var res = owner.move(delta)
		return res
	}
	
	function rotate(angle: Number): Void {
		_rotation = angle
	}
}