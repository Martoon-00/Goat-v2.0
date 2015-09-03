class colors.ColorSmoothChoice {
	private var a:Array
	
	function ColorSmoothChoice(){ // arguments - key colors
		a = new Array()
		for (var i = 0; i < arguments.length; i++) a = a.concat(arguments[i])
	}
	
	function get(k: Number){
		k = Math.max(0, Math.min(1 - 1e-5, k))
		var pos = int(k * (a.length - 1))
		var frac = k * (a.length - 1) - pos
		var color1 = a[pos]
		var color2 = a[pos + 1]
		var ans = 0;
		for (var i = 1; i < 0xFF0000; i *= 0x100){
			ans += int((((color1 / i) % 0x100) * (1 - frac) + ((color2 / i) % 0x100) * frac)) * i
		}
		return ans
	}

}