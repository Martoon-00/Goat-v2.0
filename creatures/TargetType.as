import lang.*

class creatures.TargetType {
	static var SELF = new TargetType(0x1)
	static var ALLY = new TargetType(0x2)
	static var ENEMY = new TargetType(0x4)
	static var AREA = new TargetType(0x8)
	
	static var NONE = new TargetType(0x0)
	static var ALL = new TargetType(0xF)
	
	static var OUR = SELF.unite(ALLY)
	static var OTHER = ALLY.unite(ENEMY)
	static var TARGET = AREA.complement()
	static var SELF_EX = SELF.complement()
	
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
	
	function complement(): TargetType {
		return new TargetType(ALL.value - value)
	}
	
	
	function toString(): String { return Strings.format("[TargetType %s]", value) }
}