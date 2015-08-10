class lang.MovieClipBase extends MovieClip {
	private var onEnterFrameList: Array
	
	function MovieClipBase(){ 
		var this_obj = this
		onEnterFrameList = new Array()
		watch("onEnterFrame", function(name, oldVal, newVal){ this_obj.onEnterFrameList.push(newVal); return oldVal })
	}
	
	function onEnterFrame(){
		for (var i in onEnterFrameList) 
			onEnterFrameList[i].call(this)
	}
	
}