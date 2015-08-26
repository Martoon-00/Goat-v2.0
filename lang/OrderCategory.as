import lang.*

class OrderCategory {
	var name: String
	
	var parent: OrderCategory
	var children = new Array()
	
	var exec = new Array()
	
	function OrderCategory(name: String, parent: OrderCategory) {
		this.watch("parent", function(prop, oldVal, newVal){
			Arrays.remove(oldVal.children, this)
			newVal.children.push(this)
			return newVal
		})
		this.parent = parent
		
		this.name = name
	}
	
	function addExec(f: Function): OrderCategory {
		exec.push(f)
		return this
	}
	
	function toString(): String { return name }
	
}