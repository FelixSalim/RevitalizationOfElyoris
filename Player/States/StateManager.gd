# State Manager Class
class_name StateManager

# Stores states in form of dictionary
var states

# Store Each State Class in form of a Dictionary
func _init():
	states = {
		"idle" : IdleState,
		"run" : RunState
	}

# Get Requested State
func get_state(stateName):
	if states.has(stateName):
		return states[stateName]
	else:
		printerr("State ", stateName, " does not exist")
