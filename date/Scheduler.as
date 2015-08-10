import lang.*
import globals.*

class date.Scheduler {
	private var granule: Number
	
	private var tasks = new Array()
	
	private var time = 0
	
	function Scheduler(granule: Number) {
		this.granule = Optional.of(granule).orElse(1)
		var this_obj = this
		Timing.addEnterFrame(function(){ this_obj.enterFrame() })
	}
	
	function add(delay: Number, f: Function, ctx: Object){
		var future = time + int(delay / granule)
		if (tasks[future] == undefined) tasks[future] = new Array()
		tasks[future].push({f: f, ctx: ctx})
	}
	
	private function enterFrame(){
		new Stream(tasks[time]).forEachArg(call)
		delete tasks[time++]
	}
	
	private function call(task: Object){
		task.f(task.ctx)
	}
	
}