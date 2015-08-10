import labirinth.*
import dsu.*
import lang.*
import coordinates.*

// From here: http://habrahabr.ru/post/176671/
class labirinth.EulerLabirinthCreator implements LabirinthCreator {
	private var amongRowsChooser: Function
	private var underRowsChooser: Function
	
	function EulerLabirinthCreator (amongRowsChooser: Function, underRowsChooser: Function){
		this.amongRowsChooser = Optional.of(amongRowsChooser).orElse(new Judge().BALANCED_BOOLEAN)
		this.underRowsChooser = Optional.of(underRowsChooser).orElse(new Judge().BALANCED_BOOLEAN)
	}
		
	function create(columnNum: Number, rowNum: Number): Labirinth {
		var union = new Union()
		var row = Stream.generate(columnNum, function(){ return union.newElement() }).toArray()
		var lab = new Labirinth(rowNum, columnNum)
		
		lab.addBorder()
		
		// middle
		for (var rowId = 0; rowId < rowNum; rowId++){
			// walls among row
			for (var i = 0; i < columnNum - 1; i++){
				if (row[i].fromSingleSet(row[i + 1]) || rowId < rowNum - 1 && amongRowsChooser()){
					lab.getCell(i, rowId).addWalls(DirectionSet.of(Direction.RIGHT))
				} else {
					row[i].merge(row[i + 1])
				}
			}
			
			if (rowId == rowNum - 1) break
			
			// walls under row
			var setSizes = new Object()
			for (var i = 0; i < columnNum; i++){
				var setId = row[i].getSet().id
				if (setSizes[setId] == undefined)
					setSizes[setId] = 1
				else 
					setSizes[setId]++
			}	
			
			for (var i = 0; i < columnNum; i++){
				var setId = row[i].getSet().id
				if (setSizes[setId] == 1 || underRowsChooser(setSizes[setId])){
					delete setSizes[setId]
				} else {
					lab.getCell(i, rowId).addWalls(DirectionSet.of(Direction.DOWN))
					row[i] = union.newElement()
					setSizes[setId]--
				}
			}
		}
		
		lab.startPos = new Coord().random()
		lab.exitPos = new Coord().random()
		
		return lab
	}
}