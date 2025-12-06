extends InputState

@onready var menu_container: PanelContainer = $MenuContainer

# To call when the state is reached
func onEnter(states: Array[InputState]):
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	nextStates = states
	menu_container.show()
	
# To call when the state is replaced
func onExit():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	menu_container.hide()
	
# To call on any given frame - will be checking for inputs and returning operations
func process(delta: float) -> Array[InputState]:
	if isMainMenuing():
		return nextStates
	return [self]
	
# To call on any given physics frame
func physicsProcess(delta: float) -> Array[InputState]:
	return [self]
