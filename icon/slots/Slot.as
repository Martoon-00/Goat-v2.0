import icon.slots.*

class icon.slots.Slot extends MovieClip {
	var keeper: IconsKeeper
	var icon = null
	
	function setKeeper(keeper: IconsKeeper){
		this.keeper = keeper
	}
	
	function onRollOver(){
		keeper.overSlot = this
	}
	
	function onRollOut(){
		keeper.overSlot = null
	}
	
	
}