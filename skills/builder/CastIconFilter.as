import lang.*
import level.*
import skills.*
import skills.builder.*

class skills.builder.CastIconFilter implements IconFilter {
	
	function draw(filter: MovieClip, skill: Skill): Void {
		var frac = Range.UNIT.bound(skill.state.timer.get() / skill.stateInfo[SkillState.CAST].duration)
		new Drawer(filter)
			.beginFill(HotbarSlot.CAST_COLOR, 60)
			.transform(Transform.DILATATION(HotbarSlot.SIZE))
			.rectangle(-1, 1, 1 - frac * 2, 1)
	}
}