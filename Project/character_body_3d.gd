extends CharacterBody3D

@export var speed : float = 5.0
@export var jump_force : float = 4.5
@export var gravity : float = 9.8

var camera_pivot: Node3D

func _ready():
	camera_pivot = $SpringArm3D 

var velocity_y : float = 0.0  

func _physics_process(delta):
	var input_dir = Vector3.ZERO 

	if Input.is_action_pressed("move_forward"):
		input_dir += Vector3.FORWARD
	if Input.is_action_pressed("move_backward"):
		input_dir -= Vector3.FORWARD
	if Input.is_action_pressed("move_left"):
		input_dir -= Vector3.RIGHT
	if Input.is_action_pressed("move_right"):
		input_dir += Vector3.RIGHT

	if input_dir != Vector3.ZERO:
		input_dir = input_dir.normalized()  
		input_dir = camera_pivot.global_transform.basis * input_dir  
		input_dir.y = 0  
		velocity.x = input_dir.x * speed
		velocity.z = input_dir.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		velocity.z = move_toward(velocity.z, 0, speed * delta)

	
	velocity_y -= gravity * delta
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity_y = jump_force

	velocity.y = velocity_y  
	move_and_slide()
