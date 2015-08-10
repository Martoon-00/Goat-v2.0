import lang.*

class Constants {
	static var msgObj = {
		__resolve: function(name: String) { 
			return { toString: function(){ return name } } 
		}
	}
	
}