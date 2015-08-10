import skills.*
import globals.*
import lang.*

class skills.CastController {
	private var casting = new Array()
	
	function CastController() {
		var _this = this
	}
	
	function available(skill: Skill): Boolean { 
		if (skill.multicast < casting.length) return false
		for (var i in casting) { 
			if (casting[i].skill.multicast < casting.length) return false
		}
		return true
	}
	
	function cast(skillCtx: Object, listener: Object): Void {
		var _this = this
		var skill = skillCtx.skill
		
		// pointer
		var pointer = MovieClips.attachUniqueMovie(_global._field, "target_pointer", 100, {
			color: 0xFF3000
		})
		skillCtx.target.getCoord().assign(pointer)
		
		// cast animation
		var mc = MovieClips.attachUniqueMovie(_global._field.upperEffects, skill.castMc, 0, {
				_rotation: skillCtx.target.getCoord().minus(skill.caster.getCoord()).rotation()  
		})
		var followCaster = function(){ skill.caster.getCoord().assign(mc) }
		followCaster()
		Functions.makeMultiListener(mc, "onUnload")
		mc.onUnload = skill.caster.moving.onMove.register(followCaster)
		
		mc.onFinish = function(){ removeMovieClip(this) }
		mc.onInterrupt = function(){ mc.onFinish() }
		
		// this
		casting.push(Objects.copy(listener, {
			skill: skill,
			skillCtx: skillCtx,
			pointer: pointer,
			mc: mc
		}))
		
		// initiate
		skill.state.start()
		
		var removers = new Listener()
		// interrupt on move
		if (!skill.moveAllowed) {
			removers.register(skill.caster.moving.onMove.register(function(){  
				skill.state.reset()
				removers.invoke()
			}))
		}
		// success when ready
		removers.register(skill.state.setFinishListener(SkillState.CASTING, function(){  
			_this.success(skill) 
			removers.invoke()
		}))
		// interrupt when reset
		removers.register(skill.state.setResetListener(SkillState.CASTING, function(){
			_this.interrupt(skill)													 
			removers.invoke()
		}))
	}
	
	private function success(skill: Skill): Void {  // not for handling outside, manage with SkillState instead
		var info = findSkill(skill)
		info.skillCtx.onCastFinish()
		info.skill.use()	
		info.mc.onFinish()
		end(skill)
	}
	
	private function interrupt(skill: Skill): Void { // see above ^^^
		var info = findSkill(skill)
		info.skillCtx.onCastInterrupt()
		info.mc.onInterrupt()
		end(skill)
	}
	
	private function end(skill: Skill): Void {  
		var index = findSkillIndex(skill)
		casting[index].pointer.onDestroy()
		casting.splice(index, 1)
		
		delete skill.curCtx.onCastFinish
		delete skill.curCtx.onCastInterrupt
		skill.curCtx = null
	}
	
	function findSkill(skill: Skill): Object {
		return Optional.of(casting[findSkillIndex(skill)]).orElse(null)
	}
	
	private function findSkillIndex(skill: Skill): Number { 
		for (var i in casting) { 
			if (casting[i].skill == skill) {
				return i
			}
		}
		return null
	}
	
}