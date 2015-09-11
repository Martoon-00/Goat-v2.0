import creatures.*
import skills.*
import coordinates.*

class skills.builder.CustomTarget {
	private var requiredType: TargetType
	
	function CustomTarget(type: TargetType) { 
		requiredType = type
	}
	
	function make(){
		var _this = this
		return {
			targetReq: function(skill: Skill, target: TargetCoord){  
				var targetType = skill.caster.recognizeTarget(target.getTarget())
				return _this.requiredType.contains(targetType)
			}
		}
	}
	
	
}