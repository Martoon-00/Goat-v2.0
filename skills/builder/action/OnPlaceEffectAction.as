import lang.*

class skills.builder.action.OnPlaceEffectAction {
	private var effectMc: String
	private var params: Object
	
	function OnPlaceEffectAction(effectMc: String, params: Object) {
		this.effectMc = effectMc
		this.params = params
	}
	
	function make() {
		var _this = this
		return {
			actions: function(skillCtx) {   
				var mc = MovieClips.attachUniqueMovie(_global._field, _this.effectMc, 10000, _this.params
					.set("_pos", skillCtx.target.getCoord())
				)
				
			}
		}
	}
	
}