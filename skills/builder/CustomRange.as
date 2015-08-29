import coordinates.*
import skills.*

class skills.builder.CustomRange {
	private var range: Number
	
	function CustomRange(range: Number) {
		this.range = range
	}
	
	function make() {
		var _this = this
		return {
			targetReq: function(skill: Skill, target: TargetCoord){
				var caster = skill.caster
				return caster.getCoord().minus(target.getCoord()).dist() <= _this.range
			}
		}
	}
	
}