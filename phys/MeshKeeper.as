import phys.*
import lang.*
import coordinates.*
import geom.*

class phys.MeshKeeper {
	private static var debug = 0
	
	private var a: DiArray
	
	var meshSize: Number
	
	function MeshKeeper(meshSize: Number) {
		var _this = this
		a = new DiArray()
			.setResolve(function(i: Number, j: Number){ return new Mesh(_this, i, j) })
		this.meshSize = meshSize
	}
	
	private function getMesh(c: Coord) { return a.get(Math.floor(c.x / meshSize), Math.floor(c.y / meshSize)) }
	
	function register(obj: Hitbox): Function { 
		return getMesh(Coord.ZERO).objs.register(obj)
	}
	
	function move(obj: Hitbox, from: Coord, to: Coord, remover: Function): Function { 
		var fromMesh = getMesh(from)
		var toMesh = getMesh(to)
		if (fromMesh == toMesh) return remover;
		
		//getMeshesOnPath(from, to)
		
		if (!(remover instanceof Function)) throw new Error("MeshKeeper.move: remover is invalid")
		remover()
		return toMesh.objs.register(obj)
	}
	
	function getMeshesOnPath(from: Coord, to: Coord) { 
		if (from.isBroken() || to.isBroken()) throw new Error("getMeshesOnPath: accepted broken coord!")
		
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
		/*trace(res)
		for (var i in res){
			if (res[i]["mc"] + "" == "") trace("ololol!")
		}
		trace("----")*/
		return res
	}
	
	function toString(): String { return "MeshKeeper" }
}