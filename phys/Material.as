import lang.*
import coordinates.*
import labirinth.*
import phys.*
import geom.*
import level.*

class phys.Material extends MovieClipBase {
	var lab: Labirinth  // will be init by labirinth when created by it
	var moving: MoveController
	var hitbox: Hitbox
	
	private static var category_relations = new DiArray()
		.set("creature", "wall", true)
		.set("projectile", "wall", true)
		
	function Material() {
		_global._field.meshKeeper.move(this, _pos, _pos)
		
		moving = new MoveController(this)
	}
		
	function init(lab: Labirinth): Void {
		this.lab = lab
	}
	
	/*function getCoord(): Coord {
		return _pos
	}*/
	
	function move(vector: Coord){
		_rotation = vector.angle() / Math.PI * 180
	
		var oldPos = _pos
		
		var k = 10
		while(k-- > 0) {  
			var lastPos = _pos
			var others = _global._field.meshKeeper.getHitboxesOnPath(_pos, _pos.plus(vector))
			var r = { t: 1 }
			for (var i in others) { 
				var other = others[i]
				if (other == this.hitbox || canCollide(other.mc) == false || other.mc.canCollide(this) == false) continue
				
				var res = hitbox.intersect(other, vector)
				res.hitbox = other
				if (res.t < r.t) r = res
			}
			_pos = _pos.plus(vector.times(r.t))
			if (r.t == 1) break
			
			vector.times(1 - r.t)
			var p = r.n.normal().ort()
			vector = p.times(vector.scalar(p)).plus(r.n.times(1e-9))
			
			if (category_relations.get(hitbox.category, r.other.category)) onCollision(r.other)
			if (category_relations.get(r.other.category, hitbox.category)) r.other.mc.onCollision(hitbox)
		}
		moving.onMove.invoke(oldPos, new Coord(this))
	}
	
	function canCollide(other: Material): Boolean {
		return true
	}
	
	function onCollision(): Boolean {
		return true
	}
	
}