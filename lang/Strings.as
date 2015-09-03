class lang.Strings {
	private static var _lol = new lang.FuncInvoker(init)
	private static function init() {
		var proto = String.prototype
		
		proto.replace = function(pattern: String, to: String, times: Number): String { 
			if (times == undefined) times = Number.POSITIVE_INFINITY
			var res = ""
			for (var i = 0; i < this.length; ){ 
				if (this.substr(i, pattern.length) == pattern && times > 0) { 
					res += to
					i += pattern.length
					times--
				} else {
					res += this.charAt(i++)
				}
			}
			return res
		}
		
		proto.find = function() {
			for (var i = 0; i < this.length; i++) {
				for (var j = 0; j < arguments.length; j++) {
					if (this.substr(i, arguments[j].length) == arguments[j]) 
						return i;
				}
			}
			return -1
		}
		
		proto.fill = function() {
			return Strings.format.apply(null, new Array().concat(this).concat(arguments))
		}
		
		_global.ASSetPropFlags(proto, null, 0x7)
	}
	
	
	static function format(s: String){
		var argIndex = 1
		while (true) {
			var startIndex = s.indexOf("%") + 1
			if (startIndex == 0) break;
			
			var s0 = s.slice(startIndex)
			var letterIndexRel = s0.find("s", "f", "d")
			if (letterIndexRel == -1) throw new Error("Illegal pattern!")
			
			var length = Number.POSITIVE_INFINITY
			if (s.charAt(startIndex) == ".") {
				length = Number(s.substr(startIndex + 1, letterIndexRel - 1))
			}
			
			var type = s.charAt(startIndex + letterIndexRel)
			var to = "?"
			var arg = arguments[argIndex++]
			
			if (type == "s") { 
				arg = String(arg)
				to = arg.slice(0, Math.min(length, arg.length))
			} else if (type == "d") {
				to = arg
			} else if (type == "f") {
				to = int(arg)
				arg -= to
				to += "."
				for (var i = 0; i < length; i++) {
					arg *= 10
					var n = int(arg)
					to += n
					arg -= n
				}
			} else throw new Error("Strange in Strings.format()!")
			
			s = s.slice(0, startIndex - 1) + to + s.slice(startIndex + letterIndexRel + 1)
		}
		return s
	}
	
	static function charCodeRepresent(code: Number): String {
		return String.fromCharCode(code)
	}
	
	static function codeOf(s: String): Number {
		return s.charCodeAt(0)
	}
}