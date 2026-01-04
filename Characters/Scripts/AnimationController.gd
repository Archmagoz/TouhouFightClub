class_name AnimationController extends Node

# Load components
@export var animation: AnimatedSprite2D
@export var body: CharacterBody2D

# Logic variables
var current_animation := "stand"
var locked := false

# Connect the animation looped to callback to check if the attack animation ended
func _ready() -> void:
	animation.animation_looped.connect(_on_animation_finished)

# Handle the sprite X orientation if needed
func _physics_process(_delta: float) -> void:
	if body.velocity.x != 0:
		face_direction(body.velocity.x)

func face_direction(x: float) -> void:
	if abs(x) < 0.01:
		return

	animation.flip_h = x < 0

# Main function to change the animation
func change_animation(new_animation: String) -> void:
	if locked:
		return
	if current_animation == new_animation:
		return

	current_animation = new_animation
	animation.play(new_animation)

# Lock and unlock animation function
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

func attack(type: String) -> void:
	change_animation("attack" + type)
	lock()

# Callback end of attack
func _on_animation_finished() -> void:
	if current_animation.begins_with("attack") or current_animation == "jump":
		body.is_attacking = false
		unlock()
