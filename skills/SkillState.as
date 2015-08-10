import skills.*
import lang.*
import date.*

class skills.SkillState {
	static var NONE = 0
	static var CASTING = 1
	static var COOLDOWN = 2
	
	private static var LAST_STATE = COOLDOWN
	
	var skill: Skill
	var limits: Array
	
	var value = 0
	var timer: TimeCounter
	
	var listeners: Object
	
	function SkillState(skill: Skill) {
		var _this = this
		this.skill = skill
		limits = new Array(Number.POSITIVE_INFINITY, skill.castTime, skill.coolTime)
		timer = new TimeCounter()
		
		watch("value", function(prop, oldVal, newVal){ listeners[switchName(oldVal, newVal)].invoke(); _this.timer.restart(); return newVal % (LAST_STATE + 1) })
		listeners = {
			__resolve: function(name: String){ return this[name] = new Listener() }
		}
		
		globals.Timing.addEnterFrame(function(){ _this.enterFrame() })
	}
	
	function setFinishListener(value: Number, f: Function): Function { 
		return listeners[switchName(value, value + 1)].register(f)
	}
	
	function setResetListener(value: Number, f: Function): Function {
		return listeners[switchName(value, 0)].register(f)
	}
	
	function enterFrame() { 
		if (timer.get() >= limits[value]) {  
			value++
		}
	}
	
	private static function switchName(oldState, newState): String { return oldState + "_"  + newState }
	
	function start(){ 
		if (value == 0){ 
			value = 1 
		} else {
			trace("Attempt to init skill which is not ready")
		}
	}
	
	function reset(){
		value = 0
	}
}