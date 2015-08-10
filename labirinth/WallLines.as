import labirinth.*

class labirinth.WallLines {
	private var lines: Array
	
	private var lineNum: Number
	private var lineLength: Number
	
	function WallLines(lineNum: Number, lineLength: Number){
		this.lineNum = lineNum
		this.lineLength = lineLength
		
		lines = new Array(lineNum)
		for (var i = 0; i < lineNum; i++) 
			lines[i] = new Array(lineLength)
	}
	
	function setWall(line: Number, pos: Number, value: Boolean):Void {
		lines[line][pos] = value
	}
	
	function getWall(line: Number, pos: Number):Boolean {
		return lines[line][pos] == true
	}
	
	function forEachWall(f:Function){ // f: (line, pos) -> void
		for (var i = 0; i < lineNum; i++)
			for (var j = 0; j < lineLength; j++)
				if (getWall(i, j)) f(i, j)
	}
}
	