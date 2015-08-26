import lang.*
import skills.*
import creatures.*

class skills.SkillTemplate {
	private var param: Object
	
	function SkillTemplate(param: Object) {
		this.param = param
	}
	
	function newSkillInstance(caster: Creature){
		if (caster == undefined) { 
			trace("SkillTemplate.newInstance() takes exact 1 parameter")
			return null
		}
		return new Skill(param, caster)
	}
	
	function toString(): String { return "[SkillTemplate: " + param.name + "]" }
}