# Inherit Node2D
extends Node2D

# State Class
class_name State

# Stores changeState function
var changeState

# Stores player class
var player

# Stores player animation
var playerAnimation

# Move and Slide player 
func _physics_process(delta):
	player.move_and_slide()

# Initialize Class
func init(changeState, player, playerAnimation):
	self.changeState = changeState
	self.player = player
	self.playerAnimation = playerAnimation
