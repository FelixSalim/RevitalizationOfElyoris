# Inherit Node2D
extends Node2D

# State Class
class_name MovementState

# Stores changeState function
var changeState

# Stores player class
var player

# Stores animations
var playerAnimation
var hitboxAnimation

# Move and Slide player 
func _physics_process(delta):
	player.move_and_slide()

# Initialize Class
func init(changeState, player, playerAnimation, hitboxAnimation):
	self.changeState = changeState
	self.player = player
	self.playerAnimation = playerAnimation
	self.hitboxAnimation = hitboxAnimation
