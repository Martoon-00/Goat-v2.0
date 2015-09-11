import lang.*

class lang.DiArray {
	private var a: Array
	
	private var resolve: Function
	
	function DiArray() {  
		a = new Array()
	}
	
	private function index(i, j): String { return i + "_" + j }
	
	function get(i, j) { 
		var r = a[index(i, j)] 
		if (r == undefined) r = a[index(i, j)] = resolve(i, j)
		return r
	}
	function set(i, j, v: Object): DiArray { a[index(i, j)] = v; return this }
	
	function setResolve(f: Function): DiArray { resolve = f; return this }
	
}