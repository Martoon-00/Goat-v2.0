import skills.*
import lang.*
import date.*

class skills.SkillState {
	static var IDLE = 0
	static var CAST = 1
	static var ACTIVE = 2
	static var COOLDOWN = 3
	
	private static var LAST_STATE = 3
	
	var skill: Skill
	var limits: Array
	
	var value = 0
	var timer: TimeCounter
	var effectMc: MovieClip
	
	var listeners: Object
	
	function SkillState(skill: Skill) {
		var _this = this
		this.skill = skill
		timer = new TimeCounter()
		limits = new Stream(skill.stateInfo).map(function(){ return this.duration }).toArray()
		
		watch("value", onChange)
		listeners = {
			__resolve: function(name: String){ return this[name] = new Listener() }
		}
		
		globals.Timing.addEnterFrame(function(){ _this.enterFrame() })
	}
	
	function onChange(prop, oldVal, newVal) {
		listeners[switchName(oldVal, newVal)].invoke() 
		if (oldVal + 1 == newVal) onForward()
		else if (newVal == 0) onReset()

		setEffectMovie(newVal)
		
		timer.restart() 
		return newVal % (LAST_STATE + 1)
	}
	
	function onForward(): Void { 
		effectMc.onFinish()
	}
	
	function onReset(): Void {
		effectMc.onInterrupt()
	}
	
	function setEffectMovie(state: Number): Void {
		if (skill.stateInfo[state].mc == null) return
		var _this = this;
		
		effectMc = MovieClips.attachUniqueMovie(_global._field.upperEffects, skill.stateInfo[state].mc, 0, {
			skill: _this.skill																   
		})
		var followCaster = function(){ _this.skill.caster.getCoord().assign(_this.effectMc) }
		followCaster()
		effectMc.unlockMovement = skill.caster.moving.onMove.register(followCaster)
		Functions.makeMultiListener(effectMc, "onUnload")
		effectMc.onUnload = function(){ _this.effectMc.unlockMovement() }
		
		effectMc.onFinish = function(){ removeMovieClip(this) }
		effectMc.onInterrupt = function(){ _this.effectMc.onFinish() }
	}
	
	function setFinishListener(value: Number, f: Function): Function { 
		return listeners[switchName(value, value + 1)].register(f)
	}
	
	function setResetListener(value: Number, f: Function): Function {
		return listeners[switchName(value, 0)].register(f)
	}
	
	function enterFrame() { 
		while (timer.get() >= limits[value]) {  
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