extends CharacterBody2D

@export var speed_controller: SpeedController
@export var animation: AnimationController

var jump_velocity: float
var speed: float

func _ready() -> void:
	jump_velocity = speed_controller.jump_velocity
	speed = speed_controller.speed

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		animation.jump()
	
	else:
		if animation.locked:
			animation.unlock()

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		animation.walk()
		velocity.x = direction * speed
	else:
		animation.stand()
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
