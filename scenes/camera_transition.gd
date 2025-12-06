extends InputState

const EPSILON_DISTANCE = 1

@onready var in_game_menu: InputState = $"../In-GameMenu"
@onready var camera: Camera3D

# Need to be set by the caller before use - otherwise will break
var finalLocation: Vector3

# To call when the state is reached
func onEnter(states: Array[InputState]):
	nextStates = states
	
# To call when the state is replaced
func onExit():
	pass
	
# To call on any given frame - will be checking for inputs and returning operations
func process(delta: float) -> Array[InputState]:
	if (isMainMenuing()):
		in_game_menu.priorState = self
		return [in_game_menu, self]

	return [self]
	
# To call on any given physics frame
func physicsProcess(delta: float) -> Array[InputState]:
	if (camera.position.distance_to(finalLocation) > EPSILON_DISTANCE):
		# Function for moving camera - For now just interpolate
		camera.position = camera.position + (finalLocation - camera.position) * 0.2 * delta
	else:
		return [nextStates[0]]
	return [self]
