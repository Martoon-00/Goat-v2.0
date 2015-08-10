import lang.*

class globals.Timing {
	static var fps = 30
	
	static var enterFrameList = new Array()
	static var onceIndeces = new Array()
	static var broadcaster = new Object()
	
	static var _lol = new FuncInvoker(init)
	
	static function addEnterFrame(f: Function): Void {
		enterFrameList.push(f)
	}
	
	static function execOnce(f: Function): Void {
		onceIndeces.push(enterFrameList.length)
		enterFrameList.push(f)
	}
	
	private static function init(): Void {
		AsBroadcaster.initialize(broadcaster)
		_root.createEmptyMovieClip("_enterFrameKeeper", -10000).onEnterFrame = onEnterFrame
	}
	
	
	private static function onEnterFrame(): Void {
		new Stream(enterFrameList).forEachArg(Stream.CALL)
		new Stream(onceIndeces).forEachArg(function(index){ delete enterFrameList[index] })
		broadcaster.broadcastMessage("enterFrame")
	}
	
}
