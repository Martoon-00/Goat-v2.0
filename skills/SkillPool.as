import skills.*
import skills.builder.*
import skills.builder.actype.*
import skills.builder.action.*
import lang.*
import creatures.*

class SkillPool {
	private static var lol_ = new FuncInvoker(init)
	private static var pool = new Object()
	
	private static function init() { 
		_global.skillPool = new Object()
		pool = {
			__resolve: function(skillName: String) { 
				var _this = this
				return {
					obj: new SkillBuilder(skillName),
					__resolve: function(name: String) {
						var temp_this = this
						if (name == "build") { return function(){ _global.skillPool[skillName] = temp_this.obj.build() } }
						else return function(){ temp_this.obj[name].apply(temp_this.obj, arguments); return temp_this }
					}
				}
				return 0
			}
		}
		
		initSkills()
	}
	
	private static function initSkills() {
		
		pool.fire_bolt
			.plug(new ClickAcType())
			.plug(new CustomSkillState(SkillState.CAST, 1200, new MovieClipInfo("fire_cast", {color: 0xFFA000})))
			.plug(new CustomSkillState(SkillState.COOLDOWN, 300))
			.plug(new CustomTarget(TargetType.ALL))
			.plug(new StdProjectileAction(20, new MovieClipInfo("fire_bolt"))
				.addAction(new OnPlaceEffectAction("fire_explode", {damage: 80}))
			).plug(new Const("multicast", 7))
			.plug(new Const("moveAllowed", true))
			.plug(new Const("arc", 150))
			.build()
			
		pool.wave
			.plug(new ChargeAcType(350))
			.plug(new CustomSkillState(SkillState.CAST, 1200, new MovieClipInfo("fire_cast", {color: 0x47B4ED})))
			.plug(new CustomSkillState(SkillState.COOLDOWN, 2000))
			.plug(new CustomTarget(TargetType.SELF_EX))
			.plug(new StdProjectileAction(8, new MovieClipInfo("wave", {
				color: 0x47B4ED,
				speed: function(pathRemFrac, ctx, defSpeed){ return (ctx.chargeFrac * 0.8 + 0.2) * defSpeed }
				})).setDistance(250)
			).plug(new Const("multicast", 1))
			.plug(new Const("moveAllowed", false))
			.plug(new Const("arc", 150))
			.build()
			
		pool.jet
			.plug(new ChannelAcType())
			.plug(new CustomSkillState(SkillState.CAST, 300, new MovieClipInfo("fire_cast", {color: 0x47B4ED})))
			.plug(new CustomSkillState(SkillState.ACTIVE, 1900))
			.plug(new CustomSkillState(SkillState.COOLDOWN, 700))
			.plug(new CustomTarget(TargetType.SELF_EX))
			.plug(new OnCasterEffectAction("jet", {color: 0x47B4ED}))
			.plug(new Const("multicast", 8))
			.plug(new Const("moveAllowed", true))
			.plug(new Const("arc", 150))
			.build()
			
		pool.dash
			.plug(new ClickAcType())
			.plug(new CustomSkillState(SkillState.COOLDOWN, 700))
			.plug(new CustomTarget(TargetType.SELF_EX))
			.plug(new DashAction(1000))
			.plug(new Const("moveAllowed", true))
			.plug(new Const("multicast", 0))
			.plug(new Const("arc", 150))
			.build()
			
	}
}