import util.motion.*
import coordinates.*

class Motion {
	private var mc: MovieClip
	private var manager: MotionManager
	private var target: Function
	
	var unregister: Function
	
	function Motion(mc: MovieClip, manager: MotionManager, target: Function) {
		this.mc = mc
		this.target = target
		setManager(manager)
		
		var _this = this
		unregister = globals.Timing.addEnterFrame(function(){ _this.enterFrame() })
	}
	
	function setManager(manager: MotionManager): Motion {
		this.manager = manager
		return this
	}
	
	function enterFrame() {
		manager.step(new Coord(mc), target()).assign(mc)
	}
	
}