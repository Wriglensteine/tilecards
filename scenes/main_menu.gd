extends InputState

@onready var main_menu_container: PanelContainer = $MainMenuContainer


# To call when the state is reached
func onEnter(states: Array[InputState]):
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	main_menu_container.show()
	
# To call when the state is replaced
func onExit():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	main_menu_container.hide()
	
# To call on any given frame - will be checking for inputs and returning operations
func process(delta: float):
	pass
	
# To call on any given physics frame
func physicsProcess(delta: float):
	pass
