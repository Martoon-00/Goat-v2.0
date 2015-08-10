class creatures.TargetType {
	static var SELF = new TargetType(1)
	static var ALLY = new TargetType(2)
	static var ENEMY = new TargetType(4)
	static var AREA = new TargetType(8)
	
	static var NONE = new TargetType(0)
	static var OUR = SELF.unite(ALLY)
	static var OTHER = ALLY.unite(ENEMY)
	static var TARGET = SELF.unite(ALLY).unite(ENEMY)
	static var ALL = TARGET.unite(AREA)
	
	var value: Number
	
	private function TargetType(value: Number) {
		this.value = value
	}
	
	function contains(other: TargetType): Boolean {
		return (value & other.value) == other.value
	}
	
	function unite(other: TargetType): TargetType {
		return new TargetType(value | other.value)
	}
}