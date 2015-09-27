import lang.*
import phys.*
import coordinates.*

class labirinth.PhysWall extends Material {
	function PhysWall(pos: Coord, dir: Coord) {
		setHitbox(new Hitbox("wall", Coord.ZERO, new Line(Coord.ZERO, dir.times(1 / 2), Range.DIUNIT)))
		place(pos)
	}
}