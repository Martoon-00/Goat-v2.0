import lang.*
import skills.*
import skills.builder.filter.*

class skills.builder.CustomIconFilter {
	private var state: Number
	private var filter: IconFilter
	
	function CustomIconFilter(state: Number, filter: IconFilter) {
		this.state = state
		this.filter = filter
	}
	
	function make() {
		return {
			iconFilter: Objects.create(state, filter)
		}
	}
	
}