import coordinates.*
import lang.*

class lang.MovieClipBase extends MovieClip {
	var _pos: Coord
	
	function addListener() {
		super.addListener.apply(this, arguments)
	}
	
	function place(pos: Coord): MovieClipBase {
		super.place(pos)
		return this
	}
}