extends InputState

# Needs reference to character3D and camera attached to it
@onready var player: Player = $"../../Player"
@onready var camera_transition: Node = $"../CameraTransition"
@onready var in_game_menu: Node = $"../In-GameMenu"

@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
var CAMERA_CONTROLLER : Camera3D = player.get_node("CameraNeck/Camera")
@export var MOUSE_SENSITIVITY : float = 0.5 

var _mouse_input : bool = false
var _mouse_rotation : Vector3
var _rotation_input : float
var _tilt_input : float
var _player_rotation : Vector3
var _camera_rotation : Vector3

var GRAVITY = 10.0
var SPEED = 0.1

# To call when the state is reached
func onEnter(states: Array[InputState]):
	nextStates = states
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
# To call when the state is replaced
func onExit():
	player.velocity.x = 0.0
	player.velocity.y = 0.0
	player.velocity.z = 0.0
	
# To call on any given frame - will be checking for inputs and returning operations
func process(delta: float):	
	if (Input.is_action_just_pressed("TogglePause")):
		return [in_game_menu, self]
		
	return [self]

# To call on any given physics frame
func physicsProcess(delta: float):
	if not player.is_on_floor():
		player.velocity.y -= GRAVITY * delta
	
	var input_dir = Input.get_vector("walk_left", "walk_right", "walk_back", "walk_forward")
	var direction = (player.get_node("CameraNeck").transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()	
	if direction:
		player.velocity.x = direction.x * SPEED
		player.velocity.y = direction.z * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
		
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_UPPER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0,_mouse_rotation.y,0.0)
	_camera_rotation = Vector3(_mouse_rotation.x,0.0,0.0)
	
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	CAMERA_CONTROLLER.rotation.z = 0.0
	return [self]
