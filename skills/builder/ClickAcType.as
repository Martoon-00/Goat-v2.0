import skills.*
import lang.*
import level.*

class skills.builder.ClickAcType {
	
	function make(){ 
		return {
			control: {
				onHold: function(skill: Skill) {
					if (skill.canCast()){ 
						skill.start()
					}
				}
			},
			castIconFilter: function(skill: Skill) { 
				var frac = skill.state.timer.get() / skill.castTime
				var dr = new Drawer(this)
				dr.beginFill(HotbarSlot.CAST_COLOR, 60)
				dr.rectangle(-HotbarSlot.SIZE, HotbarSlot.SIZE, (1 - frac * 2) * HotbarSlot.SIZE, HotbarSlot.SIZE)
			}
		}
	}
	
}