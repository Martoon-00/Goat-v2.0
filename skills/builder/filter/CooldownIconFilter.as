import lang.*
import level.*
import skills.*
import skills.builder.filter.*

class skills.builder.filter.CooldownIconFilter implements IconFilter {
	
	function draw(filter: MovieClip, skill: Skill): Void {
		var frac = Range.UNIT.bound(skill.state.timer.get() / skill.stateInfo[SkillState.COOLDOWN].duration)
		new Drawer(filter)
			.beginFill(HotbarSlot.COOLDOWN_COLOR, 40)
			.transform(Transform.TURN(Math.PI / 4)).perfectPoly(4, HotbarSlot.SIZE, -Math.PI / 4, frac * 2 * Math.PI - Math.PI / 4)
	}
}