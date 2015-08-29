import lang.*
import level.*
import skills.*
import skills.builder.*

class skills.builder.ActiveIconFilter implements IconFilter {
	
	function draw(filter: MovieClip, skill: Skill): Void { 
		var frac = Range.UNIT.bound(skill.state.timer.get() / skill.stateInfo[SkillState.ACTIVE].duration)
		new Drawer(filter)
			.beginFill(HotbarSlot.ACTIVE_COLOR, 20)
			.transform(Transform.DILATATION(HotbarSlot.SIZE))
			.rectangle(-1, 1, -1, frac * 2 - 1)
	}
}