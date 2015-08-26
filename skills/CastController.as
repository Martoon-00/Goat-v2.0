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
		
		// this
		casting.push(Objects.copy(listener, {
			skill: skill,
			skillCtx: skillCtx,
			pointer: pointer
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
		removers.register(skill.state.setFinishListener(SkillState.CAST, function(){  
			_this.success(skill) 
			removers.invoke()
		}))
		// interrupt when reset
		removers.register(skill.state.setResetListener(SkillState.CAST, function(){
			_this.interrupt(skill)													 
			removers.invoke()
		}))
	}
	
	private function success(skill: Skill): Void {  // not for handling outside, manage with SkillState instead
		var info = findSkill(skill)
		info.skillCtx.onCastFinish()
		info.skill.use()	
		end(skill)
	}
	
	private function interrupt(skill: Skill): Void { // see above ^^^
		var info = findSkill(skill)
		info.skillCtx.onCastInterrupt()
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