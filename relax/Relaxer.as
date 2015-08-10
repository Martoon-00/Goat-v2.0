import relax.*
import lang.*
import date.*

// ctx contains:
// done
// times

class relax.Relaxer {
	private static var TIME_PER_FRAME = 1000 / globals.Timing.fps
	private static var ITERATION_LIMIT = 2e5
	
	private static var imTasks = new Array()    // immediate for execution at specified frame
	private static var opTasks = new Array()    // could be executed at next frames
	
	private static var remTasks = new Array()   // which should be executed early
	
	private static var time = 0
	
	private static var _lol = new FuncInvoker(init)
	
	private static function init(){
		globals.Timing.addEnterFrame(enterFrame)
		imTasks.__resolve = opTasks.__resolve = function(name){ return this[name] = new Array() }
	}
	
	static function register(f: Function, delay: Number, immediate: Boolean): Void { 
		addTask(Optional.of(delay).orElse(0), new Task(f, {times: 1}), immediate)
	}
	
	private static function addTask(delay: Number, task: Task, immediate: Boolean){ 
		var tasks = immediate != false ? imTasks : opTasks
		tasks[time + delay].push(task)
	}
	
	private static function enterFrame(){
		var timer = new TimeCounter()
		
		processTasks(imTasks[time], Number.POSITIVE_INFINITY)
		delete imTasks[time]
		
		Arrays.concat(opTasks[time], remTasks)
		processTasks(opTasks[time], TIME_PER_FRAME * 0.7 - timer.get())
		remTasks = Arrays.concat(null, opTasks[time])
		
		time++
	}
	
	private static function processTasks(tasks: Array, timeLimit: Number): Void { 
		var timeCounter = new TimeCounter()
		var remTaskNum = tasks.length
		
		var haveTime = true
		for (var it = 0; it < ITERATION_LIMIT && remTaskNum > 0 && haveTime; it++){ 
			for (var i in tasks){
				var task = tasks[i]
				task.f(task.ctx)
				
				if (task.ctx.done){
					if (task.ctx.done != -1) {
						addTask(Number(task.ctx.done), task)
						task.ctx.times = Number(task.ctx.done)
					}
					delete task.ctx.done
					delete tasks[i]
					remTaskNum--
				}
				if (timeCounter.get() >= timeLimit){ 
					haveTime = false
					break
				}
			}
			
			if (it + 1 == ITERATION_LIMIT) trace("Relaxer: some function exceed iteration limit")
		}
		
	}
	
	static function MULTY_ACTION(k: Number, f: Function, singleExecution: Boolean): Function { 
		return function(ctx) { 
			if (ctx._time == undefined){
				ctx._time = 0
			}
			f(ctx)
			if (++ctx._time == k){
				ctx.done = singleExecution ? -1 : true
				ctx._time = 0
			}
		} 
	}
	
}