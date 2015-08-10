import relax.*

class relax.Task {
	private var f: Function
	private var ctx: Object
	
	function Task(f:Function, ctx:Object) {
		this.f = f
		this.ctx = ctx
	}
}