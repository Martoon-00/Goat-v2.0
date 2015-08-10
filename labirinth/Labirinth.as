import coordinates.*
import labirinth.*
import lang.*

class labirinth.Labirinth {
	var wallV: WallLines
	var wallH: WallLines
	
	var sizeV: Number
	var sizeH: Number
	var cellSize: Number
	
	var startPos: Coord
	var exitPos: Coord
	
	function Labirinth(sizeV: Number, sizeH: Number, cellSize: Number){
		this.sizeV = sizeV
		this.sizeH = sizeH
		this.cellSize = cellSize
		wallV = new WallLines(sizeH + 1, sizeV)
		wallH = new WallLines(sizeV + 1, sizeH)
	}
	
	function getCell(x:Number, y:Number): Cell {
		return new Cell(this, new Coord(x, y))
	}
	
	function addBorder(){
		for (var i = 0; i < sizeV; i++){
			getCell(0, i			).addWalls(DirectionSet.of(Direction.LEFT))
			getCell(sizeH - 1, i).addWalls(DirectionSet.of(Direction.RIGHT))
		}
		for (var i = 0; i < sizeH; i++){
			getCell(i,			0).addWalls(DirectionSet.of(Direction.UP))
			getCell(i, sizeV - 1).addWalls(DirectionSet.of(Direction.DOWN))
		}
	}
	
	function modify(): Labirinth {
		var this_obj = this
		new Stream(arguments).forEachArg(function(modifier){ modifier.modify(this_obj) })
		return this
	}
	
	function draw(mc:MovieClip):MovieClip {
		mc.clear()
		mc.lineStyle(2)
		
		var cellSize = this.cellSize
		wallV.forEachWall(function(line:Number, pos:Number): Void {
			mc.moveTo(line * cellSize, pos * cellSize) 
			mc.lineTo(line * cellSize, (pos + 1) * cellSize)
		})
		wallH.forEachWall(function(line:Number, pos:Number): Void {
			mc.moveTo(pos * cellSize, line * cellSize)
			mc.lineTo((pos + 1) * cellSize, line * cellSize)
		})
		
		mc.lineStyle(5, 0x808080)
		mc.moveTo(0, 0)
		mc.lineTo(0, sizeV * cellSize)
		mc.lineTo(sizeH * cellSize, sizeV * cellSize)
		mc.lineTo(sizeH * cellSize, 0)
		mc.lineTo(0, 0)
	
		return mc
	}
}