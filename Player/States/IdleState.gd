# Inherit State Class
extends MovementState

# IdleState Class
class_name IdleState

# Movement Handling, Change State to Run, calls the function stored in changeState (a.k.a change_state)
func move_left():
	changeState.call("run")

func move_right():
	changeState.call("run")

func move_up():
	changeState.call("run")

func move_down():
	changeState.call("run")
