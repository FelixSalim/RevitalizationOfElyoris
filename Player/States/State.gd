# Inherit Node2D
extends Node2D

# State Class
class_name State

# Stores changeState function
var changeState

# Stores player class
var player

# Move and Slide player 
func _physics_process(delta):
	player.move_and_slide()

# Initialize Class
func init(changeState, player):
	self.changeState = changeState
	self.player = player
