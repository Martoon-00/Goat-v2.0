import lang.*
import level.*
import skills.*
import skills.builder.*

class skills.builder.ChargeIconFilter implements IconFilter {
	private var precastTime: Number
	
	function ChargeIconFilter(precastTime: Number) {
		this.precastTime = precastTime
	}
	
	function draw(filter: MovieClip, skill: Skill): Void {
		var frac = Range.UNIT.bound(skill.state.timer.get() / skill.stateInfo[SkillState.CAST].duration)
		var edge = precastTime / skill.stateInfo[SkillState.CAST].duration
		new Drawer(filter)
			.transform(Transform.DILATATION(HotbarSlot.SIZE))
			
			.beginFill(HotbarSlot.CAST_COLOR, 60)
			.rectangle(-1, 1, 1 - Math.min(frac, edge) * 2, 1)
			
			.beginFill(HotbarSlot.CHARGE_COLOR, 60)
			.rectangle(-1, 1, 1 - Math.max(frac, edge) * 2, 1 - edge * 2)
	}
}