extends Node

# Starting state
@onready var state: Node = $TestState1

func _ready() -> void:
	state.onEnter()
	
func _process(delta: float) -> void:
	var nextState = state.process(delta)
	handleStateChange(nextState)
	
func _physics_process(delta: float) -> void:
	var nextState = state.physicsProcess(delta)
	handleStateChange(nextState)

func handleStateChange(newState: InputState):
	if (newState != state):
		state.onExit()
		state = newState
		newState.onEnter()
