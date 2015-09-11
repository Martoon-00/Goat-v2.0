import phys.*
import lang.*
import coordinates.*
import level.*
import geom.*

class level.MeshKeeper {
	private static var debug = true
	
	private var a: DiArray
	
	var meshSize: Number
	
	function MeshKeeper(meshSize: Number) {
		var _this = this
		a = new DiArray()
			.setResolve(function(i: Number, j: Number){ return new Mesh(_this, i, j) })
		this.meshSize = meshSize
	}
	
	private function getMesh(c: Coord) { return a.get(Math.floor(c.x / meshSize), Math.floor(c.y / meshSize)) }
	
	function register(obj: Hitbox) { 
		getMesh(Coord.ZERO).objs.push(obj)
	}
	
	function move(obj: Hitbox, from: Coord, to: Coord): Void { 
		var fromMesh = getMesh(from)
		var toMesh = getMesh(to)
		if (fromMesh == toMesh) return;
		
		//getMeshesOnPath(from, to)
		
		fromMesh.objs.remove(obj)
		toMesh.objs.push(obj)
	}
	
	function getMeshesOnPath(from: Coord, to: Coord) { 
		var delta = to.minus(from)
		if (delta.x == 0) delta.x += 1e-5
		
		var _this = this
		var res = new Array()
		
		var dx = delta.x > 0 ? 1 : -1
		var dy = delta.y > 0 ? 1 : -1
		
		var meshSize = this.meshSize
		var xRange = new Range(from.x, to.x).times(1 / meshSize).sub(Range.UNIT)
		var yRange = new Range(from.y, to.y).times(1 / meshSize).sub(Range.UNIT)
		
		xRange.iterate(function(i: Number) { 
			yRange.iterate(function(j: Number){
				res.push(_this.a.get(i, j))
			})
		})
		
		if (debug) for (var i in res) res[i].draw()
		return res
	}
	
	function getHitboxesOnPath(from: Coord, to: Coord): Array { 
		var meshes = getMeshesOnPath(from, to)
		var res = new Array()
		for (var i in meshes){ 
			Arrays.concat(res, meshes[i].objs)
		}
		return res
	}
	
	function toString(): String { return "MeshKeeper" }
}