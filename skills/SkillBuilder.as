import skills.*
import util.slots.*
import lang.*

class skills.SkillBuilder {
	private static var requiredSlotList = 
	[
		"name",
		"control",  
		"stateInfo0", "stateInfo1", "stateInfo2", "stateInfo3",
		"castIconFilter",
		"multicast",
		"moveAllowed",
		"arc",
		"icon"
	]
	private static var multiSlotList = 
	[
		"req",      // requirements
		"targetReq",    // requirements, which depends on target
		"actions"   // actions
	]
		
	private var builder: SlotBuilder
	
	private var descs = new Array()  // descriptions
	
	function SkillBuilder(name: String){  
		builder = new SlotBuilder(requiredSlotList, multiSlotList)
			.setName(name)
			.add({
				name: name,
				icon: new MovieClipInfo(name + "_icon"),
				stateInfo0: new SkillStateInfo(Number.POSITIVE_INFINITY, null), 
				stateInfo1: new SkillStateInfo(0, null), 
				stateInfo2: new SkillStateInfo(0, null), 
				stateInfo3: new SkillStateInfo(0, null)
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