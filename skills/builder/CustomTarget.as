import creatures.*

class skills.builder.CustomTarget {
	private var type: TargetType
	
	function CustomTarget(type: TargetType) {
		this.type = type
	}
	
	function make(){
		return {
			req: function(skillCtx){
				return true
			}
		}
	}
	
	
}