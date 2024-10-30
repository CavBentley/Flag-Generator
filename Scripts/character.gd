extends CharacterBody3D


const SPEED = 5.0
const SPRINT_SPEED = 5.0
const JUMP_VELOCITY = 4.5
const crouchSpeed = 2.0
const max_rotation = 1.5

var crouched = false
var flashlightOn = false

@export var sensitivity = 3

@onready var flashlight = $Camera3D/DirectionalLight3D
@onready var soundPlayer = $AudioStreamPlayer3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
		
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed = SPEED
	
	if Input.is_action_just_pressed("shift"):
		speed = SPRINT_SPEED
		
	#if Input.is_action_just_released("shift"):
		#speed = SPEED
	
	if Input.is_action_pressed("crouch"):
		speed = crouchSpeed
		if !crouched:
			$AnimationPlayer.play("crouch_anim")
			crouched = true
	else:
		if crouched:
			var space_state = get_world_3d().direct_space_state
			var result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(position, position + Vector3(0,2,0), 1, [self]))
			if result.size() == 0:
				$AnimationPlayer.play("uncrouch")
				crouched = false
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / 1000 * sensitivity
		$Camera3D.rotation.x -= event.relative.y / 1000 * sensitivity
		rotation.x = clamp(rotation.x, PI / -2, PI / 2)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -max_rotation, max_rotation)
	if event.is_action_pressed("flashlight") and !flashlightOn:
		flashlightOn = true
		soundPlayer.play()
		flashlight.light_energy = 1
	elif event.is_action_pressed("flashlight") and flashlightOn:
		flashlightOn = false
		soundPlayer.play()
		flashlight.light_energy = 0
