class_name InputState
extends Node

# To call when the state is reached
func onEnter():
	pass
	
# To call when the state is replaced
func onExit():
	pass
	
# To call on any given frame - will be checking for inputs and returning operations
func process(delta: float):
	pass
	
# To call on any given physics frame
func physicsProcess(delta: float):
	pass
