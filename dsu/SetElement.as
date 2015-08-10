import dsu.*

class dsu.SetElement {
	private var set: Union
	var id: Number 
	private var parent: SetElement 
	private var rank: Number
	
	function SetElement(set: Union, id: Number){ this.set = set, this.id = id, parent = this, rank = 0 }
	
	function equals(other: SetElement){ return id == other.id }
	
	function fromSingleSet(other: SetElement){ return getSet().equals(other.getSet()) }
	
	private function getSet():SetElement {
		if (equals(parent)) return this;
		return parent = parent.getSet()
	}
	
	function merge(other: SetElement):Void {
		var set1 = getSet()
		var set2 = other.getSet()
		
		if (set1.equals(set2)) return;
		
		if (set1.rank > set2.rank) set2.parent = set1.parent
		else set1.parent = set2.parent
		if (set1.rank == set2.rank) set2.rank++
	}
	
	function toString(): String {
		return "{Element " + id + ", group " + getSet().id + "}"
	}
}