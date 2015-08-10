class lang.Strings {
	static function format(s: String){
		var curArg = 1
		var res = ""
		for (var i = 0; i < s.length; i++){
			if (s.charAt(i) == "\\"){ 
				i++;
				res += s.charAt(i)
			}
			else if (s.substr(i, 2) == "%s"){
				i++
				res += arguments[curArg++]
			}
			else res += s.charAt(i)
		}
		return res
	}
	
	static function charCodeRepresent(code: Number): String {
		return String.fromCharCode(code)
	}
	
	static function codeOf(s: String): Number {
		return s.charCodeAt(0)
	}
}