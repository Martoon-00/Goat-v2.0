import skills.*
import skills.builder.*
import lang.*
import creatures.*

class SkillPool {
	private static var lol_ = new FuncInvoker(init)
	
	private static function init() { 
		_global.skillPool = {
			__resolve: function(skillName: String) { 
				var _this = this
				return {
					obj: new SkillBuilder(skillName),
					__resolve: function(name: String) {
						var temp_this = this
						if (name == "build") { return function(){ _this[skillName] = temp_this.obj.build() } }
						else return function(){ temp_this.obj[name].apply(temp_this.obj, arguments); return temp_this }
					}
				}
				return 0
			}
		}
		
		initSkills()
	}
	
	private static function initSkills() {
		
		_global.skillPool.fire_bolt
			.plug(new ClickAcType())
			.plug(new CustomCast(1200, new MovieClipInfo("fire_cast", {color: 0xFFA000})))
			.plug(new Const("coolTime", 300))
			.plug(new CustomTarget(TargetType.ALL))
			.plug(new StdProjectileAction(20, new MovieClipInfo("fire_bolt"))
				.addAction(new OnPlaceEffectAction("fire_explode", {damage: 80}))
			).plug(new Const("multicast", 2))
			.plug(new Const("moveAllowed", true))
			.plug(new Const("arc", 150))
			.build()
			
		_global.skillPool.wave
			.plug(new ChargeAcType(500))
			.plug(new CustomCast(1200, new MovieClipInfo("fire_cast", {color: 0x47B4ED})))
			.plug(new Const("coolTime", 2000))
			.plug(new CustomTarget(TargetType.ALL))
			.plug(new StdProjectileAction(8, new MovieClipInfo("wave", {
				color: 0x47B4ED,
				countSpeed: function(frac, ctx, defSpeed){ return (ctx.chargeFrac * 0.8 + 0.2) * defSpeed }
				})).setDistance(250)
			).plug(new Const("multicast", 1))
			.plug(new Const("moveAllowed", false))
			.plug(new Const("arc", 150))
			.build()
			
			
	}
}