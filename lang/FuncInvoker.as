class lang.FuncInvoker {
	function FuncInvoker(f:Function){ 
		_global.setTimeout(f, 0)
	}
}