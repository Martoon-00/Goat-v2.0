import skills.*
import util.slots.*
import lang.*

class skills.SkillBuilder {
	private static var requiredSlotList = 
	[
		"name",
		"control", 
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
	private static var mergeableSlotList = 
	[ 
		"stateInfo",
		"iconFilter"
	]
		
	private var builder: SlotBuilder
	
	private var descs = new Array()  // descriptions
	
	function SkillBuilder(name: String){  
		builder = new SlotBuilder(requiredSlotList, multiSlotList, mergeableSlotList)
			.setName(name)
			.add({
				name: name,
				icon: new MovieClipInfo(name + "_icon"),
				stateInfo: SkillState.DEFAULT_STATE_INFO,
				iconFilter: SkillState.DEFAULT_ICON_FILTER
			})
	}
	
	function plug(plug): SkillBuilder {  
		builder.plug(plug) 
		return this 
	}
	
	function add(plug): SkillBuilder {
		builder.add(plug)
		return this
	}
	
	function build(): SkillTemplate { 
		//Objects.print(builder.slots.iconFilter)
		return new SkillTemplate(builder.build()) 
	}
	
	function get(prop: String): Object {
		return builder.get(prop)
	}
}