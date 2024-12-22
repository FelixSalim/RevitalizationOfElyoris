# Inherit State Class
extends MovementState

# IdleState Class
class_name IdleState

# Movement Handling, Change State to Run, calls the function stored in changeState (a.k.a change_state)
# Also makes sure player is not interacting
func move_left():
	if not player.isInteracting:
		changeState.call("run")

func move_right():
	if not player.isInteracting:
		changeState.call("run")

func move_up():
	if not player.isInteracting:
		changeState.call("run")

func move_down():
	if not player.isInteracting:
		changeState.call("run")
