import lang.*
import level.*
import skills.*

class level.HotbarSlot extends MovieClipBase {
	static var SIZE = 18
	
	static var CAST_COLOR = 0xE69300
	static var CHARGE_COLOR = 0xFF2000
	static var COOLDOWN_COLOR = 0x0000FF
	
	var keys: Array
	var skill: Skill
	
	private var controlRemovers: Array
	private var mouseListener: MouseListener
	
	private var icon: MovieClip
	private var background: MovieClip
	private var filter: MovieClip
	var visible = true
	
	private var keyText: MovieClip
	
	private var parent: Hotbar
	
	function HotbarSlot() { 
		var _this = this
		if (keys == undefined) keys = new Array()
		
		watch("keys", new Functions().WATCH_ARRAY)
		watch("visible", function(prop, oldVal, newVal){
			if (oldVal != newVal) {
				globals.Timing.execOnce(function(){ _this.parent.onPlacementChanged() })
			}
			return _this._visible = newVal
		})
		watch("skill", function(prop, oldVal, newVal){ 
			icon.removeMovieClip() 
			var mc = attachMovie(newVal.icon.name, "icon", 100, newVal.icon.param)
			if (mc == undefined) attachMovie("def_icon", "icon", 100, newVal.icon.param)
			
			_this.reassignKeys(newVal.control)
			
			_this.visible = newVal != null
			return newVal
		})
		
		new Drawer(createEmptyMovieClip("background", 10))
			.beginFill(0xE1DFE1)
			.square(20)
		keyText.swapDepths(110)
		createEmptyMovieClip("filter", 200)
		
		keyText.textField.text = String.fromCharCode(keys[0])
		
		mouseListener = new MouseListener(background)
		
		skill = skill
	}
		
	function onEnterFrame(): Void { 
		applyState()
	}
	
	function applyState(): Void {
		filter.clear()
		if (skill.state.value == SkillState.CAST){
			skill.castIconFilter.call(filter, skill)
		} else if (skill.state.value == SkillState.COOLDOWN) {
			var frac = Math.min(skill.state.timer.get() / skill.stateInfo[SkillState.COOLDOWN].duration, 1)
			var dr = new Drawer(filter)
			dr.beginFill(COOLDOWN_COLOR, 40)
			dr.transform(Transform.TURN(Math.PI / 4)).perfectPoly(4, HotbarSlot.SIZE, -Math.PI / 4, frac * 2 * Math.PI - Math.PI / 4)
		}
	}
	
	function reassignKeys(newControl: Object): Void {
		if (newControl == undefined) return;
		
		new Stream(controlRemovers).forEachArg(Stream.CALL)
		controlRemovers = new Array()
		
		for (var i in keys) { 
			var remover = KeyListener.register(keys[i], newControl)
			controlRemovers.push(remover)
		}
		mouseListener.register(newControl)
	}
}