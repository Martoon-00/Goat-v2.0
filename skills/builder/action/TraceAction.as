import lang.*

class skills.builder.action.TraceAction {
	private var message: String
	
	function TraceAction(message: String) {
		this.message = Optional.of(message).orElse("action!")
	}
	
	function make(){
		var this_ = this
		return {
			actions: function(ctx: Object){ 
				trace(this_.message) 
				trace("---")
				trace("context:")
				Objects.print(ctx)
				trace("")
				trace("")
			}
		}
	}
}