extends InputState

@onready var test_state_2: Node = $"../TestState2"
var timeSinceChange: float = 0.0

func onEnter():
	print("Entering State 1")
	timeSinceChange = 0.0

func onExit():
	print("Exiting State 1")
	
func process(delta: float):
	timeSinceChange += delta
	if (timeSinceChange > 1.0):
		return test_state_2
	return self
	
func physicsProcess(delta: float):
	return self
