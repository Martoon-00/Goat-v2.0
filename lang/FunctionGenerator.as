class lang.FunctionGenerator {
	
	function createResolve(f: Function) {
		return {
			__resolve: f.call(this)
		}
	}
	
}