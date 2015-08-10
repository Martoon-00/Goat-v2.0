import labirinth.*
import coordinates.*
import lang.*

class labirinth.SmallDeadendCleaner implements LabirinthModifier {
	private var removalJudge;  // some function which randomly returns false or true
	
	function SmallDeadendCleaner(removalJudge: Function){
		this.removalJudge = removalJudge == null
							 ? new Judge().ALWAYS_TRUE
							 : removalJudge
	}
	
	function modify(lab: Labirinth): Void {
		for (var i = 0; i < lab.sizeH; i++){
			for (var j = 0; j < lab.sizeV; j++){
				var curCoord = new Coord(i, j)
				var curCell = lab.getCell(i, j)
				var removalJudge = this.removalJudge
				new Stream(Direction.values()).forEachArg(function(dir){ 
					if (curCell.getWalls().equals(curCell.getAdjacent(dir).getWalls()) && removalJudge()){
						curCell.removeWalls(DirectionSet.of(dir))
					}
				})
			}
		}
		
		// border might be damaged
		lab.addBorder()
	}
	
}