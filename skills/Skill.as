import skills.*
import builgs.*
import coordinates.*
import lang.*
import creatures.*

class skills.Skill {
	var name: String
	var icon: MovieClipInfo
	
	var control: Object
	var castAvailable: Function
	var start: Function
	var use: Function
	
	var stateInfo: Array
	var castIconFilter: Function
	var multicast: Number
	var moveAllowed: Boolean
	
	var caster: Creature
	
	var state: SkillState
	var curCtx: Object
	
	function Skill(params: Object, caster: Creature) { 
		var _this = this
		this.caster = caster
		
		control = new Object()
		Objects.iterate(params.control, function(name, listener){  
			_this.control[name] = function(){ listener(_this) } 
		})
		
		castAvailable = function(): Boolean { 
			if (_this.state.value != SkillState.IDLE) return false
			if (!caster.casting.available(_this)) return false
			if (!moveAllowed && Hero(caster).moving.target != null) return false
			
			var req = params.req
			for (var i = 0; i < req.length; i++){ 
				if (!req[i](_this)) return false
			}
			return true
		}
		
		use = function(): Void {
			for (var i = 0; i < params.actions.length; i++) {
				params.actions[i](_this.curCtx)
			}	
		}
		
		start = function(): Boolean {
			if (!_this.castAvailable()) return false;
				
			var req = params.targetReq
			for (var i = 0; i < req.length; i++){
				if (!req[i](_this, _this.curCtx)) return false
			}
				
			var _this = this
			curCtx = {
				id: _global.Counter.skillId,
				skill: this,
				caster: caster,
				target: _global._field.getCurTarget(),
				toString: function(): String { return "[" + _this.name + " context #" + this.id + "]" }
			}
			caster.casting.cast(curCtx)			
			return true
		}
		
		stateInfo = [params.stateInfo0, params.stateInfo1, params.stateInfo2, params.stateInfo3]
		castIconFilter = params.castIconFilter
		multicast = params.multicast
		moveAllowed = params.moveAllowed
		name = params.name
		icon = params.icon
		state = new SkillState(this)
	}

	
	function toString(): String { return "[Skill: " + name + "]" }
}