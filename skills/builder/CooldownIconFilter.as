import lang.*
import level.*
import skills.*
import skills.builder.*

class skills.builder.CooldownIconFilter implements IconFilter {
	
	function draw(filter: MovieClip, skill: Skill): Void {
		var frac = Math.min(skill.state.timer.get() / skill.stateInfo[SkillState.COOLDOWN].duration, 1)
		new Drawer(filter)
			.beginFill(HotbarSlot.COOLDOWN_COLOR, 40)
			.transform(Transform.TURN(Math.PI / 4)).perfectPoly(4, HotbarSlot.SIZE, -Math.PI / 4, frac * 2 * Math.PI - Math.PI / 4)
	}
}