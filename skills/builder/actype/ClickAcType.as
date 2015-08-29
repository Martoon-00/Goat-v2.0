import skills.*
import lang.*
import level.*

class skills.builder.actype.ClickAcType {
	
	function make(){ 
		return {
			control: {
				onHold: function(skill: Skill) {
					skill.start()
				}
			}
		}
	}
	
}