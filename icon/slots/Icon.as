import icon.slots.*

class icon.slots.Icon extends MovieClip {
	var keeper: IconsKeeper
	var slot: Slot
	
	function setKeeper(keeper: IconsKeeper){
		this.keeper = keeper
	}
	
	function setSlot(slot: Slot){
		this.slot = slot
		this._x = slot._x
		this._y = slot._y
	}
	
}