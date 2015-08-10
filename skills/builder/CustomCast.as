import lang.*

class skills.builder.CustomCast {
	var castTime: Number
	var castMc: MovieClipInfo
	
	function CustomCast(castTime: Number, castMc: MovieClipInfo) {
		this.castTime = castTime
		this.castMc = castMc
	}
	
	function make(): Object {
		return this
	}
	
	
}