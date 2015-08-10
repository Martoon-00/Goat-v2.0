class date.TimeCounter {
	private var start: Date
	
	function TimeCounter(){
		start = new Date()
	}
	
	function restart(): Number {
		var res = new Date() - start
		start = new Date()
		return res
	}
	
	function get(): Number {
		return new Date() - start
	}
}