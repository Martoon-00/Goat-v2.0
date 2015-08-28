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
		
		// interrupt on move
		var moveDeli: Function
		if (!skill.moveAllowed) 
			moveDeli = skill.caster.moving.onMove.register(function(){ skill.state.reset() })
		skill.state.setEndListener(SkillState.CAST, function(){ _this.end(skill) })
		
		// this
		casting.push(Objects.copy(listener, {
			skill: skill,
			skillCtx: skillCtx,
			pointer: pointer,
			moveDeli: moveDeli
		}))
		
	}
	
	private function end(skill: Skill): Void {  
		var index = findSkillIndex(skill)
		casting[index].pointer.onDestroy()
		casting[index].moveDeli()
		casting.splice(index, 1)
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