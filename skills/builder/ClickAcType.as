import skills.*
import lang.*
import level.*

class skills.builder.ClickAcType {
	
	function make(){ 
		return {
			control: {
				onHold: function(skill: Skill) {
					skill.start()
				}
			},
			castIconFilter: function(skill: Skill) { 
				var frac = skill.state.timer.get() / skill.stateInfo[SkillState.CAST].duration
				new Drawer(this)
					.beginFill(HotbarSlot.CAST_COLOR, 60)
					.rectangle(-HotbarSlot.SIZE, HotbarSlot.SIZE, (1 - frac * 2) * HotbarSlot.SIZE, HotbarSlot.SIZE)
			}
		}
	}
	
}