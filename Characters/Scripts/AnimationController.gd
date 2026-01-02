class_name AnimationController extends Node

# Load components
@export var animation: AnimatedSprite2D
@export var body: CharacterBody2D

# Current animation and logic variables
var current_animation := "none"
var locked := false

# Simple change sprite orientation if needed
func _physics_process(_delta: float) -> void:
	if body.velocity.x != 0:
		face_direction(body.velocity.x)

func face_direction(x: float) -> void:
	if abs(x) < 0.01:
		return

	animation.flip_h = x < 0

# Main function to change animations
func change_animation(new_animation: String) -> void:
	if locked:
		return

	if current_animation == new_animation:
		return

	current_animation = new_animation
	animation.play(new_animation)

# Lock/unlock animation
func lock() -> void:
	locked = true

func unlock() -> void:
	locked = false

# Avaliable animations
func walk() -> void:
	change_animation("walk")

func stand() -> void:
	change_animation("stand")

func jump() -> void:
	change_animation("jump")
	lock()
