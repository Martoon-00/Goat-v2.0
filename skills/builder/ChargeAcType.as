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
					if (skill.canCast()){ 
						skill.start()
						skill.curCtx.timer = new TimeCounter()
						skill.curCtx.onCastFinish = function() {
							var ctx = skill.curCtx
							ctx.chargeTime = Math.min(ctx.timer.get(), skill.castTime) - _this.precastTime
							ctx.totalChargeTime = skill.castTime - _this.precastTime
							ctx.addProperty("chargeFrac", function(){ return this.chargeTime / this.totalChargeTime }, null)
							delete ctx.timer
						}
						skill.curCtx.onCastInterrupt = function() {
						}
					}
				},
				onRelease: function(skill: Skill): Void { 
					if (skill.state.value != SkillState.CASTING) return;
					
					var ctx = skill.curCtx
					if (ctx.timer.get() < _this.precastTime){
						skill.state.reset()
					} else {
						skill.state.value++
					}
				}
			},
			castIconFilter: function(skill: Skill) { 
				var frac = skill.state.timer.get() / skill.castTime
				var edge = _this.precastTime / skill.castTime
				var dr = new Drawer(this)
				dr.beginFill(HotbarSlot.CAST_COLOR, 60)
				dr.rectangle(-HotbarSlot.SIZE, HotbarSlot.SIZE, (1 - Math.min(frac, edge) * 2) * HotbarSlot.SIZE, HotbarSlot.SIZE)
				if (frac > edge){
					dr.beginFill(HotbarSlot.CHARGE_COLOR, 60)
					dr.rectangle(-HotbarSlot.SIZE, HotbarSlot.SIZE, (1 - Math.max(frac, edge) * 2) * HotbarSlot.SIZE, (1 - Math.min(frac, edge) * 2) * HotbarSlot.SIZE)
				}
			}
		}
	}
}