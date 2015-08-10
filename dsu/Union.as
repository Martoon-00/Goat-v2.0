import dsu.*

class Union {
	private var elements = new Array()
	
	function newElement(): SetElement {
		var e = new SetElement(this, elements.length)
		elements.push(e)
		return e
	}
	
	function getElement(id: Number) { return elements[id] }
}