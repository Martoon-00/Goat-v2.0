import lang.*
import skills.*
import level.*

class skills.builder.ChannelAcType {
	
	function make() {
		return {
			control: {
				onHold: function(skill: Skill) {
					skill.start()					
				},
				onRelease: function(skill: Skill) {
					var state = skill.state
					if (state.value == SkillState.CAST) state.reset()
					else if (state.value == SkillState.ACTIVE) state.value++
				}
			}
		}
	}
}