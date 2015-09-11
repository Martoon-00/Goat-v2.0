import skills.*
import lang.*
import date.*
import skills.builder.*
import skills.builder.filter.*
import util.motion.*

class skills.SkillState {
	static var IDLE = 0
	static var CAST = 1
	static var ACTIVE = 2
	static var COOLDOWN = 3
	
	private static var LAST_STATE = 3
	
	static var DEFAULT_STATE_INFO = [
		new SkillStateInfo(Number.POSITIVE_INFINITY, null), 
		new SkillStateInfo(0, null),
		new SkillStateInfo(0, null),
		new SkillStateInfo(0, null)
	]
	static var DEFAULT_ICON_FILTER = [
		null,
		new CastIconFilter(),
		new ActiveIconFilter(),
		new CooldownIconFilter()
	]
	
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
		var success: Boolean
		if (oldVal + 1 == newVal) success = true
		else if (newVal == 0) success = false
		else trace("Unknown state change")
		
		listeners[switchName(oldVal, newVal)].invoke(success)
		if (newVal == 0 || newVal == LAST_STATE + 1) {
			for (var i in listeners) listeners[i].clear()
			skill.curCtx = null
		}
		if (success) onForward()
		else onReset()
		
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
		}).setMotion(new ImmediateMotion(), function(){ return _this.skill.caster._pos })
		
		effectMc.onFinish = function(){ removeMovieClip(this) }
		effectMc.onInterrupt = function(){ _this.effectMc.onFinish() }
	}
	
	function setFinishListener(value: Number, f: Function) { listeners[switchName(value, value + 1)].register(f) }
	function setResetListener (value: Number, f: Function) { listeners[switchName(value, 0)].register(f) }
	function setEndListener   (value: Number, f: Function) { setFinishListener(value, f); setResetListener(value, f) }
	
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