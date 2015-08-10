import labirinth.*
import coordinates.*
import lang.*

class labirinth.Cell {
	private var lab: Labirinth
	private var coord: Coord

	function Cell(lab: Labirinth, coord: Coord) { this.lab = lab, this.coord = coord }

	function setWalls(walls: DirectionSet):Void {
		var lab = this.lab
		var coord = this.coord
		new Stream(Direction.values()).forEach(function(){
			this.setWall(lab, coord, walls.contains(this)) 
		})
	}
	
	function addWalls(walls: DirectionSet):Void {
		var lab = this.lab
		var coord = this.coord
		new Stream(walls.toArray()).forEach(function(){
			this.setWall(lab, coord, true) 
		})
	}
	
	function removeWalls(walls: DirectionSet):Void {
		var lab = this.lab
		var coord = this.coord
		new Stream(walls.toArray()).forEach(function(){
			this.setWall(lab, coord, false) 
		})
	}
	
	function getWalls():DirectionSet {
		var lab = this.lab
		var coord = this.coord
		return new Stream(Direction.values())
			.filter(function(){ return this.getWall(lab, coord) })
			.collect(
				DirectionSet.EMPTY,
				DirectionSet.EMPTY.add
			)
	}
	
	function getAdjacent(dir: Direction):Cell {
		return new Cell(lab, coord.plus(dir.toCoord()))
	}
	
	function toString():String {
		return "{cell " + coord + " " + getWalls() + "}" 
	}
}