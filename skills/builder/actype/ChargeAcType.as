import lang.*
import date.*
import skills.*
import level.*
import lang.*
import skills.builder.*
import skills.builder.filter.*

class skills.builder.actype.ChargeAcType {
	private var precastTime: Number
	
	function ChargeAcType(precastTime: Number){
		this.precastTime = Optional.of(precastTime).orElse(0)
	}
	
	function make(){
		var _this = this
		return Objects.copy(
			{
				control: {
					onHold: function(skill: Skill): Void { 
						if (skill.start()){  
							skill.curCtx.timer = new TimeCounter()
							skill.state.setFinishListener(SkillState.CAST, function() {  
								var ctx = skill.curCtx
								ctx.chargeTime = Math.min(ctx.timer.get(), skill.stateInfo[SkillState.CAST].duration) - _this.precastTime
								ctx.totalChargeTime = skill.stateInfo[SkillState.CAST].duration - _this.precastTime
								ctx.addProperty("chargeFrac", function(){ return this.chargeTime / this.totalChargeTime }, null)
								delete ctx.timer
							})
						}
					},
					onRelease: function(skill: Skill): Void { 
						if (skill.state.value != SkillState.CAST) return;
						
						var ctx = skill.curCtx
						if (ctx.timer.get() < _this.precastTime){
							skill.state.reset()
						} else {
							skill.state.value++
						}
					}
				}
			},
			new CustomIconFilter(SkillState.CAST, new ChargeIconFilter(precastTime)).make()
		)
	}
}