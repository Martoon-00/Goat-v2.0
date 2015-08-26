import lang.*
import date.*
import skills.*
import level.*
import lang.*

class skills.builder.ChargeAcType {
	private var precastTime: Number
	
	function ChargeAcType(precastTime: Number){
		this.precastTime = Optional.of(precastTime).orElse(0)
	}
	
	function make(){
		var _this = this
		return {
			control: {
				onHold: function(skill: Skill): Void { 
					if (skill.start()){  
						skill.curCtx.timer = new TimeCounter()
						skill.curCtx.onCastFinish = function() {
							var ctx = skill.curCtx
							ctx.chargeTime = Math.min(ctx.timer.get(), skill.stateInfo[SkillState.CAST].duration) - _this.precastTime
							ctx.totalChargeTime = skill.stateInfo[SkillState.CAST].duration - _this.precastTime
							ctx.addProperty("chargeFrac", function(){ return this.chargeTime / this.totalChargeTime }, null)
							delete ctx.timer
						}
						skill.curCtx.onCastInterrupt = function() {
						}
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
			,
			castIconFilter: function(skill: Skill) { 
				var frac = skill.state.timer.get() / skill.stateInfo[SkillState.CAST].duration
				var edge = _this.precastTime / skill.stateInfo[SkillState.CAST].duration
				new Drawer(this)
					.beginFill(HotbarSlot.CAST_COLOR, 60)
					.rectangle(-HotbarSlot.SIZE, HotbarSlot.SIZE, (1 - Math.min(frac, edge) * 2) * HotbarSlot.SIZE, HotbarSlot.SIZE)
					.beginFill(HotbarSlot.CHARGE_COLOR, 60)
					.rectangle(-HotbarSlot.SIZE, HotbarSlot.SIZE, (1 - Math.max(frac, edge) * 2) * HotbarSlot.SIZE, (1 - edge * 2) * HotbarSlot.SIZE)
					
			}
		}
	}
}