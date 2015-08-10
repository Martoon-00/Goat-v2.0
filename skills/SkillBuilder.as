import skills.*
import util.slots.*
import lang.*

class skills.SkillBuilder {
	private static var requiredSlotList = 
	[
		"name",
		"control",  // activation type, can contain "onPress", "onHold", e.t.c. functions, which would be called on skill invokation
		"castTime",
		"castMc",
		"castIconFilter",
		"coolTime",
		"multicast",
		"moveAllowed",
		"arc",
		"icon"
	]
	private static var multiSlotList = 
	[
		"req",      // requirements
		"actions"   // actions
	]
		
	private var builder: SlotBuilder
	
	private var descs = new Array()  // descriptions
	
	function SkillBuilder(name: String){  
		builder = new SlotBuilder(requiredSlotList, multiSlotList)
			.setName(name)
			.add({
				name: name,
				icon: new MovieClipInfo(name + "_icon")
			})
	}
	
	function plug(plug): SkillBuilder {  
		descs = descs.concat(plug.description())
		builder.plug(plug) 
		return this 
	}
	
	function add(plug): SkillBuilder {
		builder.add(plug)
		return this
	}
	
	function build(): SkillTemplate { 
		return new SkillTemplate(builder.build()) 
	}
	
	function get(prop: String): Object {
		return builder.get(prop)
	}
}