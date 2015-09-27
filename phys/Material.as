import lang.*
import coordinates.*
import phys.*
import geom.*
import level.*
import lang.*

class phys.Material extends MovieClipBase {
	var moving: MoveController
	private var hitbox: Hitbox
	
	private static var category_relations = new DiArray()
		.set("creature", "wall", true)
		.set("projectile", "wall", true)
		
	function Material() {
		var _this = this
		
		moving = new MoveController(this)
		addListener("onUnload", function(){ _this.hitbox.destroy() })
	}
		
	function setHitbox(hitbox: Hitbox): Material {
		this.hitbox.destroy()
		this.hitbox = hitbox
			.setMaterial(this)
		return this
	}
	
	function move(vector: Coord){
		_rotation = vector.rotation()
	
		var oldPos = _pos
		
		var k = 10
		_global._field.clear()
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
			
			/*new Drawer(_global._field)
				.transform(Transform.MOVE(_pos))
				.lineStyle(2, 0xFF00FF)
				.moveTo(0, 0).lineTo(r.n.times(100))
				
				.lineStyle(2, 0x00FF00)
				.moveTo(0, 0).lineTo(p.times(100))
				
				.lineStyle(2, 0x0000FF)
				.moveTo(0, 0).lineTo(vector.times(100))
			*/
			if (category_relations.get(hitbox.category, r.other.category)) onCollision(r.other)
			if (category_relations.get(r.other.category, hitbox.category)) r.other.mc.onCollision(hitbox)
		}
		moving.onMove.invoke(oldPos, _pos)
	}
	
	function canCollide(other: Material): Boolean {
		return true
	}
	
	function onCollision(): Boolean {
		return true
	}
	
}