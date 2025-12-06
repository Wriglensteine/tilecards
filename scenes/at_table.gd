extends InputState

# Needs reference to character3D and camera attached to it
@onready var player: Player = $"../../Player"
@onready var camera_transition: Node = $"../CameraTransition"
@onready var in_game_menu: Node = $"../In-GameMenu"
@onready var free_roam: Node = $"../FreeRoam"

var current_position_neutral: bool = true

# To call when the state is reached
func onEnter(states: Array[InputState]):
	nextStates = states
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
# To call when the state is replaced
func onExit():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
# To call on any given frame - will be checking for inputs and returning operations
func process(delta: float):
	if (Input.is_action_just_pressed("look_left")):
		camera_transition.finalLocation = Vector3(0, 2, 2)
		return [camera_transition, self]
	if (Input.is_action_just_pressed("look_right")):
		camera_transition.finalLocation = Vector3(2, 2, 2)
		return [camera_transition, self]
	if (Input.is_action_just_pressed("look_forward")):
		camera_transition.finalLocation = Vector3(2, 3, 3)
		return [camera_transition, self]
	if (Input.is_action_just_pressed("look_neutral")):
		if (!current_position_neutral):
			camera_transition.finalLocation = Vector3(2, 2, 2)
			return [camera_transition, self]
		else:
			camera_transition.finalLocation = Vector3(0, 0, 0)
			return [camera_transition, free_roam]
		
	if (Input.is_action_just_pressed("TogglePause")):
		return [in_game_menu, self]
		
	return [self]

# To call on any given physics frame
func physicsProcess(delta: float):
	pass
