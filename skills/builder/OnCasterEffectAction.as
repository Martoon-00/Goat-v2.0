﻿import lang.*

class skills.builder.OnCasterEffectAction {
	private var effectMc: String
	private var params: Object
	
	function OnCasterEffectAction(effectMc: String, params: Object) {
		this.effectMc = effectMc
		this.params = params
	}
	
	function make() {
		var _this = this
		return {
			actions: function(skillCtx) {    
				var mc = MovieClips.attachUniqueMovie(_global._field, _this.effectMc, 10000, Objects.createCopy(_this.params, {
					ctx: skillCtx  
				}))
				skillCtx.skill.caster.getCoord().assign(mc)
			}
		}
	}
	
}