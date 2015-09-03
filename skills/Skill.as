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
	var iconFilter: Array
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
			if (!Arrays.check(params.req, true, _this)) return false
			return true
		}
		
		use = function(): Void {  
			for (var i = 0; i < params.actions.length; i++) {
				params.actions[i](_this.curCtx)
			}	
		}
		
		start = function(): Boolean {
			if (!_this.castAvailable()) return false;
			
			var target = _global._field.getCurTarget()
			if (!Arrays.check(params.targetReq, true, _this, target)) return false
				
			var _this = this
			curCtx = {
				id: _global.Counter.skillId,
				skill: this,
				caster: caster,
				target: target,
				toString: function(): String { return "[" + _this.name + ": ctx #" + this.id + "]" }
			}
			_this.state.setEndListener(SkillState.ACTIVE, Functions.makeMultiListener(curCtx, "onActivationEnd"))
			
			_this.state.setFinishListener(SkillState.CAST, function(){ _this.use() })
			caster.casting.cast(curCtx)			
			state.start()
			
			return true
		}
		
		stateInfo = params.stateInfo.copy(new Array())
		iconFilter = params.iconFilter.copy(new Array())
		multicast = params.multicast
		moveAllowed = params.moveAllowed
		name = params.name
		icon = params.icon
		state = new SkillState(this)
	}

	
	function toString(): String { return "[Skill: " + name + "]" }
}