import skills.*
import builgs.*
import coordinates.*
import lang.*
import creatures.*

class skills.Skill {
	var name: String
	var icon: MovieClipInfo
	
	var control: Object
	var canCast: Function
	var use: Function
	
	var castTime: Number
	var castMc: MovieClipInfo
	var castIconFilter: Function
	var coolTime: Number
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
		
		canCast = function(target: TargetCoord){ 
			if (_this.state.value != SkillState.NONE) return false
			if (!caster.casting.available(_this)) return false
			if (!moveAllowed && Hero(caster).moving.target != null) return false
			for (var i = 0; i < params.req.length; i++){ 
				if (!params.req[i](_this, target)) return false
			}
			return true
		}
		
		use = function(): Void {
			for (var i = 0; i < params.actions.length; i++) {
				params.actions[i](_this.curCtx)
			}	
		}
		
		castTime = params.castTime
		castMc = params.castMc
		castIconFilter = params.castIconFilter
		coolTime = params.coolTime
		multicast = params.multicast
		moveAllowed = params.moveAllowed
		name = params.name
		icon = params.icon
		state = new SkillState(this)
	}

	
	function start(): Void { 
		//if (!canCast()) return; 
		var _this = this
		
		curCtx = {
			id: _global.Counter.skillId,
			skill: this,
			caster: caster,
			target: _global._field.getCurTarget(),
			toString: function(): String { return "[" + _this.name + " context #" + this.id + "]" }
		}
		caster.casting.cast(curCtx)
	}
	
	function toString(): String { return "[Skill: " + name + "]" }
}