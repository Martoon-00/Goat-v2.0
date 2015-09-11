import creatures.*
import phys.*
import skills.*
import lang.*

class creatures.Creature extends Material {
	var casting: CastController
	
	function Creature() {
		casting = new CastController()
	}
	
	function onRollOver(): Void { _global._field.selectedCreature = this }
	function onDragOver(): Void { _global._field.selectedCreature = this }
	function onRollOut(): Void { _global._field.selectedCreature = null }
	function onDragOut(): Void { _global._field.selectedCreature = null }
	
	function recognizeTarget(target: Material): TargetType { 
		if (target == undefined) return TargetType.AREA
		if (target == this) return TargetType.SELF
		if (!(target instanceof Creature)) {
			trace("Attempt to recognize target type of not creature: " + this)
		}
		
		return TargetType.ENEMY
	}
	
}