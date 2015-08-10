﻿import lang.*

class lang.MovieClips {
	
	static function getAvailableDepth(mc: MovieClip, startDepth: Number){
		for (var depth = Optional.of(startDepth).orElse(1000); depth < 1e5; depth++){ 
			if (mc.getInstanceAtDepth(depth) == null) return depth
		}
	}
	
	static function createEmptyMovieClip(parent: MovieClip, name: String, startDepth: Number){
		return parent.createEmptyMovieClip(name, getAvailableDepth(parent, startDepth))
	}
	
	static function attachMovie(parent: MovieClip, mcInfo, mcName: String, startDepth: Number, params: Object) {
		if (!(mcInfo instanceof MovieClipInfo)) mcInfo = new MovieClipInfo(mcInfo)
		return parent.attachMovie(mcInfo.name, mcName, getAvailableDepth(parent, startDepth), Objects.copy(mcInfo.param, Objects.createCopy(params)))
	}
	
	static function attachUniqueMovie(parent: MovieClip, libName, startDepth: Number, params: Object) {
		var id = _global.Counter["attachUniqueMovie_" + parent] 
		if (startDepth == null) startDepth = 0
		return attachMovie(parent, libName, "unique_" + id, startDepth, params)
	}
	
	static function createUniqueMovieClip(parent: MovieClip, startDepth: Number) {
		if (startDepth == null) startDepth = 0
		return createEmptyMovieClip(parent, "unique_" + _global.Counter["createUniqueMovieClip_" + parent], startDepth)
	}
	
}