import skills.*
import lang.*

class skills.builder.StdProjectileAction {
	private var mcInfo: MovieClipInfo
	private var speed: Number
	private var homing: Boolean
	private var distance: Number

	private var actions = new Array()
	
	function StdProjectileAction(speed: Number, mcInfo: MovieClipInfo) {
		this.mcInfo = mcInfo
		this.speed = speed
		
		homing = false
		distance = Number.POSITIVE_INFINITY
	}
	
	function addAction(plug): StdProjectileAction {
		actions = actions.concat(plug.make().actions)
		return this
	}
	
	function setDistance(value: Number): StdProjectileAction {
		distance = value
		return this
	}
	
	function setHoming(value): StdProjectileAction {
		homing = Optional.of(value).orElse(true)
		return this
	}
	
	function make() {
		var _this = this
		return {
			actions: function(skillCtx){ 
				var mc = MovieClips.attachUniqueMovie(_global._field.upperEffects, "std_projectile", null, {
					keeper: _this,
					ctx: skillCtx
				})
				skillCtx.caster.getCoord().assign(mc)
				
				if (!homing) mc.ctx.target = mc.ctx.target.fixed()
			}
		}
	}
}
