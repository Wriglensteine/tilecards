extends Node

# Starting state
@onready var state: Node = $TestState1

# This can be set by other nodes - primarily the table
var receivedNewStates: Array[InputState] = []

func _ready() -> void:
	state.onEnter()
	
func _process(delta: float) -> void:
	var nextStates = state.process(delta)
	handleStateChange(nextStates)
	
func _physics_process(delta: float) -> void:
	var nextStates = state.physicsProcess(delta)
	handleStateChange(nextStates)

func handleStateChange(newStates: Array[InputState]):
	if (receivedNewStates.size() != 0):
		state.onExit()
		state = receivedNewStates[0]
		if (receivedNewStates.size() > 1):
			state.onEnter(receivedNewStates.slice(1))
		else:
			state.onEnter([])
		
	if (newStates[0] != state):
		state.onExit()
		state = newStates[0]
		if (newStates.size() > 1):
			state.onEnter(newStates.slice(1))
		else:
			state.onEnter([])
		state.onEnter(newStates.slice(1))
		
	receivedNewStates = []
