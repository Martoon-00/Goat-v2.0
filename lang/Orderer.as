import lang.*

class lang.Orderer {
	private static var _lol = new FuncInvoker(init)
	
	private static var rootCategory
	private static var categoryList
	
	private static function init() {
		Functions.makeMultiListener(_root, "onEnterFrame")
		_root.onEnterFrame = enterFrame
		
		rootCategory = new OrderCategory(null)
	}
	
	private static function enterFrame() {
		
	}
	
	function setOrder(before: OrderCategory, after: OrderCategory): Orderer {
		var ancestorList = new Array()
		for (var i = before; i != null; i = before.parent) {
			ancestorList.push(i)
			if (i == after) {
				trace(Strings.format("Attempt to create category loop adding %s -> %s", before, after))
				trace(Strings.format("Such chain already exists: %s", ancestorList.join(" -> ")))
			}
		}
		
		after.parent = before
		return this
	}
	
	function addExec(categoryName: String, f: Function): Orderer {
		var category = new Stream(categoryList).filter(function(){ return this.name == categoryName }).toArray()[0]
		if (category == null) category = new OrderCategory(categoryName, rootCategory)
		
		rebuildTree()
		
		return this
	}
	
	function rebuildTree(): Void {
		
	}
}