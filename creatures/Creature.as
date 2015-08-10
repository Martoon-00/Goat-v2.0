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
	
	function getTargetType(): TargetType {
		trace(Strings.format("Target type of %s is not defined", this))
		return null
	}
	
}