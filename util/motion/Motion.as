import util.motion.*
import coordinates.*
import lang.*

class Motion {
	private var mc: MovieClip
	private var manager: MotionManager
	private var target: Function
	
	private var unregister: Function
	
	var onReach: Function
	
	function Motion(mc: MovieClip, manager: MotionManager, target: Function) {
		this.mc = mc
		this.target = target
		setManager(manager)
		Functions.makeMultiListener(this, "onReach")
		
		var _this = this
		unregister = globals.Timing.addEnterFrame(function(){ _this.enterFrame() })
	}
	
	function setManager(manager: MotionManager): Motion {
		this.manager = manager
		return this
	}
	
	function enterFrame() {
		mc._pos = manager.step(new Coord(mc), target())
	}
	
}