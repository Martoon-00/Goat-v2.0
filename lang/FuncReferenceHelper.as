import lang.*

class lang.FuncReferenceHelper {
	private var obj = null
	
	function FuncReferenceHelper(obj: Object) { 
		this.obj = obj
	}
	
	private function __resolve(name: String) {  
		return new FuncReference(obj, name)
	}
}