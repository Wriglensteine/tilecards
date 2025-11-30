extends InputState

@onready var test_state_1: Node = $"../TestState1"
var timeSinceChange: float = 0.0

func onEnter():
	print("Entering State 2")
	timeSinceChange = 0.0

func onExit():
	print("Exiting State 2")
	
func process(delta: float):
	timeSinceChange += delta
	if (timeSinceChange > 1.0):
		return test_state_1
	return self
	
func physicsProcess(delta: float):
	return self
