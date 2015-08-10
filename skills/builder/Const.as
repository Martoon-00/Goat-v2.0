class skills.builder.Const {
	private var slot: String
	private var value: Object
	
	function Const(slot: String, value: Object) {
		this.slot = slot
		this.value = value
	}
	
	function make() {
		var res = new Object()
		res[slot] = value
		return res
	}
}