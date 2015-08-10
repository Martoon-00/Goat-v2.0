class lang.Angle {
	private var a: Number
	
	var value: Number
	var radian: Number
	
	private function Angle(a: Number) {
		this.a = a
		
		var _this = this
		addProperty("value", function(){ return _this.a }, null)
		addProperty("radian", function(){ return _this.a / 180 * Math.PI }, null)
	}
	
	static function of(a: Number): Angle { return new Angle(a) }
	static function ofRad(rad: Number): Angle { return new Angle(rad / Math.PI * 180) }
	
	function upTo(other: Angle): Angle {
		var a = this.a
		while (a > other.a) a -= 360
		while (a < other.a) a += 360
		return new Angle(a)
	}
	
	function isBetween(start: Angle, end: Angle): Boolean {
		return upTo(start).a <= end.upTo(start).a
	}
	
	function toString(): String { return (a + 360 * 1e3) % 360 + " deg." }
}