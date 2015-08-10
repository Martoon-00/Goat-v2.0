class lang.MovieClipInfo {
	var name: String
	var param: Object
	
	function MovieClipInfo(name: String, param: Object) {
		this.name = name
		this.param = param
	}
	
	function toString(): String { return "[MovieClipInfo " + name + "]" }
}