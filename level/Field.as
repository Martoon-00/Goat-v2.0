import coordinates.*
import lang.*
import creatures.*
import level.*
import phys.*
import geom.*

class level.Field extends MovieClipBase {
	var hero: Hero
	var selectedCreature: Creature
	
	var meshKeeper: MeshKeeper
	
	var getFocus: Function  // () -> coord of camera focus
	var mouse: MouseListener
	
	var lowerEffects: MovieClip
	var upperEffects: MovieClip
	
	function Field() {
		_global._field = this
		
		var _this = this
		getFocus = function(){ return _this.hero._pos }
		
		meshKeeper = new MeshKeeper(150)
		
		var bg = new Drawer(createEmptyMovieClip("background", 0))
			.beginFill(0xFFFFFF, 80)
			.square(1e9)
			.getMovieClip()
		mouse = new MouseListener(bg)
		
		selectedCreature = null
		
		createEmptyMovieClip("lowerEffects", 100)
		createEmptyMovieClip("upperEffects", 20000)
		createEmptyMovieClip("hitboxes", 1000000)
		
	}
	
	function getCurTarget(): TargetCoord {
		return selectedCreature == null 
			? TargetCoord.ofCoord(new Coord(_xmouse, _ymouse))
			: TargetCoord.ofTarget(selectedCreature)
	}
	
	private function centerFocus(){
		_pos = Coord.ZERO.minus(getFocus())
	}
	
}