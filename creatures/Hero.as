import creatures.*
import lang.*
import coordinates.*
import skills.*
import phys.*

class creatures.Hero extends Creature {
	
	function Hero(){ 
		var _this = this
		
		// camera focus
		_global._field.centerFocus()
		moving.onMove.register(function(){ _global._field.centerFocus() })
		
		// movement
		_global._field.mouse.onHold = function(){  
			_this.moving.target = _global._field.getCurTarget().getCoord() 
		}
		
		swapDepths(10000)
	}

	function getTargetType(): TargetType {
		return TargetType.SELF
	}
	
}