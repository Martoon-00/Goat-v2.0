import coordinates.*
import labirinth.*

class labirinth.Direction {
	static var UP = new Direction("U", 1)
	static var DOWN = new Direction("D", 2)
	static var LEFT = new Direction("L", 4)
	static var RIGHT = new Direction("R", 8)
	
	private var letter:String
	var id:Number
	
	private function Direction(letter:String, id:Number){ this.letter = letter, this.id = id }
	
	static function values(){
		return new Array(UP, DOWN, LEFT, RIGHT)
	}
	
	function toString():String {
		return letter;
	}
	
	function setWall(lab:Labirinth, coord:Coord, value:Boolean){
		if (this == UP) {
			lab.wallH.setWall(coord.y, coord.x, value)
		} else if (this == DOWN) {
			lab.wallH.setWall(coord.y + 1, coord.x, value)
		} else if (this == LEFT) {
			lab.wallV.setWall(coord.x, coord.y, value)
		} else if (this == RIGHT) {
			lab.wallV.setWall(coord.x + 1, coord.y, value)
		} 
	}
	
	function getWall(lab: Labirinth, coord: Coord):Boolean {
		if (this == UP || this == DOWN){
			return lab.wallH.getWall(coord.y + (this == DOWN), coord.x)
		} else if (this == LEFT || this == RIGHT){
			return lab.wallV.getWall(coord.x + (this == RIGHT), coord.y)
		}  
	}
	
	function toCoord():Coord {
		return new Coord(
			this == LEFT ? -1  :  this == RIGHT ? 1  :  0,
			this == UP 	 ? -1  :  this == DOWN  ? 1  :  0
		)
	}
}