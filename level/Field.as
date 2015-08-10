import coordinates.*
import lang.*
import creatures.*

class level.Field extends MovieClip {
	var hero: Hero
	var selectedCreature: Creature
	
	var getFocus: Function  // () -> coord of camera focus
	var mouse: MouseListener
	
	var lowerEffects: MovieClip
	var upperEffects: MovieClip
	
	function Field() {
		_global._field = this
		
		var _this = this
		getFocus = function(){ return _this.hero.getCoord() }
		
		
		var bg = new Drawer(createEmptyMovieClip("background", 0))
			.beginFill(0xFFFFFF, 80)
			.square(1e9)
			.getMovieClip()
		mouse = new MouseListener(bg)
		
		selectedCreature = null
		
		createEmptyMovieClip("lowerEffects", 100)
		createEmptyMovieClip("upperEffects", 20000)
	}
	
	function getCurTarget(): TargetCoord {
		return selectedCreature == null 
			? TargetCoord.ofCoord(new Coord(_xmouse, _ymouse))
			: TargetCoord.ofTarget(selectedCreature)
	}
	
	private function centerFocus(){
		Coord.ZERO.minus(getFocus()).assign(this)
	}
	
}