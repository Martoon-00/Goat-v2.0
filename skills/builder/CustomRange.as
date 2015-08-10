class skills.builder.CustomRange {
	private var range: Number
	
	function CustomRange(range: Number) {
		this.range = range
	}
	
	function make() {
		return {
			req: function(skillCtx){
				var caster = skillCtx.caster
				var target = skillCtx.target
				return caster.getCoord().minus(target.getCoord()).dist() <= range
			}
		}
	}
	
}