import lang.*

class lang.Range {
	private var a: Number
	private var b: Number
	
	function Range(a: Number, b: Number) {
		this.a = a
		this.b = b
	}
	
	function bound(k: Number) {
		return Math.min(b, Math.max(a, k))
	}
	
}