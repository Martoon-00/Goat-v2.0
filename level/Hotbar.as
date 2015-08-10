import lang.*
import level.*

class level.Hotbar extends MovieClip {
	private static var HOLE_SIZE_H = 5
	private static var HOLE_SIZE_V = 10
	private static var keyLetters = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i']
	
	var slots: Array
	var keeper: MovieClip
	
	function Hotbar() {
		slots = new Array()
		createEmptyMovieClip("keeper", 100)
		
		for (var i = 0; i < 8; i++) {
			putSlot([49 + i], (2 * HotbarSlot.SIZE + HOLE_SIZE_H) * (i - 3.5), -HotbarSlot.SIZE * 2 - HOLE_SIZE_V)
		}
		
		for (var i = 0; i < 8; i++) {
			var letter = keyLetters[i]
			putSlot([Strings.codeOf(letter)], (2 * HotbarSlot.SIZE + HOLE_SIZE_H) * (i - 3.5), 0)
		}
		
	}
	
	private function putSlot(keys: Array, x: Number, y: Number): HotbarSlot {
		return slots[String.fromCharCode(keys[0])] = MovieClips.attachUniqueMovie(keeper, "hotbar_slot", 100, {
			parent: this,
			keys: keys,
			_x:	x,
			_y: y
		})
	}
	
	function onPlacementChanged(): Void { 
		var s = Stream.ofObj(slots).filter(function(){ return this.visible })
		
		var sx = s.map(function(){ return this._x })
		keeper._x = -(sx.min() + sx.max()) / 2
		
		var sy = s.map(function(){ return this._y })
		keeper._y = -sy.max()
		
	}
}