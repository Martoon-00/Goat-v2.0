import level.*
import lang.*
import coordinates.*

class level.Mesh {
	private var objs: Array
	
	private var keeper: MeshKeeper
	private var i: Number
	private var j: Number
	
	function Mesh(keeper: MeshKeeper, i: Number, j: Number) {  
		objs = new Array()
		this.keeper = keeper
		this.i = i
		this.j = j
	}
	
	private var mc: MovieClip
	function draw(): Void {  
		if (this.mc != undefined) {
			this.mc._alpha = 30
			return
		}
		
		this.mc = MovieClips.createUniqueMovieClip(_global._field.hitboxes, 0)
		mc._pos = new Coord(i + 0.5, j + 0.5).times(keeper.meshSize)
		
		new Drawer(mc)
			.lineStyle(4, 0x0080FF)
			.beginFill(0x80FFFF, 30)
			.square(keeper.meshSize / 2)
		this.mc._alpha = 60
			
		var _this = this
		mc.onEnterFrame = function() {
			if ((this._alpha-=5) <= 0) { 
				this.removeMovieClip()
				_this.mc = null
			}
		}
	}
	
	function toString(): String { return Strings.format("[Mesh (%d, %d)]", i, j) }
}