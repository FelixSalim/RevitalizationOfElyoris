# State Manager Class
class_name StateManager

# Stores states in form of dictionary
var states

# Stores states script in dictionary
var stateScript

# Store Each State Class in form of a Dictionary
func _init():
	states = {
		"idle" : IdleState,
		"run" : RunState,
		"notify" : NotificationState,
		"dialogue" : DialogueState,
		"till" : TillState,
		"water" : WaterState,
		"seed" : SeedState
	}
	
	stateScript = {
		"till" : load("res://Player/States/TillState.gd"),
		"water" : load("res://Player/States/WaterState.gd"),
		"seed" : load("res://Player/States/SeedState.gd")
	}

# Get Requested State
func get_state(stateName):
	if states.has(stateName):
		return states[stateName]
	else:
		printerr("State ", stateName, " does not exist")
		
# Get Requested State Script
func get_state_script(stateName):
	if stateScript.has(stateName):
		return stateScript[stateName]
	else:
		printerr("State ", stateName, " does not exist")
