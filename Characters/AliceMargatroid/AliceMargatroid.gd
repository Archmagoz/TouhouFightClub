extends CharacterBody2D

# Load components
@export var speed_controller: SpeedController
@export var animation: AnimationController

# Logic variables
var is_attacking := false
var jump_velocity: float
var speed: float

func _ready() -> void:
	jump_velocity = speed_controller.jump_velocity
	speed = speed_controller.speed

func _physics_process(delta: float) -> void:
	_handle_attack()
	_handle_movement(delta)

func _handle_attack() -> void:
	if Input.is_action_just_pressed("A1") and is_on_floor():
		start_attack("A1")
		
	if Input.is_action_just_pressed("A4") and is_on_floor():
		start_attack("A4")

func _handle_movement(delta: float) -> void:
	if is_attacking:
		return
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		animation.jump()
		
	else:
		if animation.locked:
			animation.unlock()

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("left", "right")

	if direction:
		animation.walk()
		velocity.x = direction * speed
	else:
		animation.stand()
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func start_attack(type: String) -> void: 
	if is_attacking:
		return
	
	is_attacking = true
	animation.attack(type)
