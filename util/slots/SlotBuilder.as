import lang.*
import util.slots.*

class util.slots.SlotBuilder {
	private static var EMPTY_SLOT = new Constants().msgObj.EMPTY_SLOT
	
	var slots: Object
	private var plugs: Object
	
	private var name: String
	
	function SlotBuilder(required: Array, multi: Array) { 
		slots = new Object()
		plugs = new Object() 
		
		for (var i in required){ 
			slots[required[i]] = EMPTY_SLOT
		}
		for (var i in multi){
			slots[multi[i]] = new Array()
		}
	}
	
	function add(plug: Object): SlotBuilder {
		for (var i in plug){ 
			if (slots[i] == undefined){
				error(Strings.format("No slot '%s' needed, but plug tries to add it", i))
			} else if (slots[i] == EMPTY_SLOT) {
				slots[i] = plug[i]
				plugs[i] = plug
			} else if (slots[i].concat != undefined){ 
				slots[i] = slots[i].concat(plug[i])
			} else {
				slots[i] = plug[i]
				plugs[i] = plug
				//trace(Strings.format("Collision at slot '%s':\n\"%s\"\nand\n\"%s\"", i, plugs[i].description(), plug.description()))
			} 
		}
		return this
	}
	
	function plug(plug: Object): SlotBuilder {
		return add(plug.make())
	}
	
	function build(): Object {
		for (var i in slots){ 
			if (slots[i] == EMPTY_SLOT) { 
				error(Strings.format("Slot '%s' is empty", i))
			}
		}
		return slots
	}
	
	function get(prop: String): Object {
		return slots[prop]
	}
	
	function setName(name: String): SlotBuilder {
		this.name = name
		return this
	}
	
	function error(message: String): Void {
		if (name != undefined) message = "[" + name + "] " + message
		trace(message)
	}
	
}