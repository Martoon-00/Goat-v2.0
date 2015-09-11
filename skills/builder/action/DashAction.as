class skills.builder.action.DashAction {
	private var distLimit: Number
	
	function DashAction(distLimit: Number) {
		this.distLimit = distLimit
	}
	
	function make() {
		var _this = this
		return {
			actions: function(skillCtx) {
				var caster = skillCtx.caster
				caster.move(skillCtx.targetRel.boundLength(new Range(0, _this.distLimit)))
				caster.moving.target = null
			}
		}
	}
	
}