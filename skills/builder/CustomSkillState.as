import skills.*
import lang.*

class skills.builder.CustomSkillState {
	private var state: Number
	private var info: SkillStateInfo
	
	function CustomSkillState(state: Number, duration: Number, mc: MovieClipInfo) {
		this.state = state
		this.info = new SkillStateInfo(duration, mc)
	}
	
	function make() {
		return {
			stateInfo: Objects.create(state, info)
		}
	}
}