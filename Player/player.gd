#Player.tscn
extends KinematicBody2D

export var MAX_SPEED = 100
export var ACCELERATION = 800
export var STRUGGLE_ACCELERATION = 20
export var FRICTION = 600
export var STRUGGLE_FRICTION = 100

enum {
	MOVE,
	STRUGGLE
}

onready var input_vector = Vector2.ZERO

var state = STRUGGLE
var screen_size
var velocity = Vector2.ZERO

#MAIN FUNCTION

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		STRUGGLE:
			struggle_state(delta)
			
	PlayerStats.player_location = self.global_position

#STATE FUNCTIONS

func move_state(delta):
	get_input()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move()
	
	
func struggle_state(delta):
	get_input()
	if Input.is_action_just_pressed("action"):
		velocity = velocity.move_toward(input_vector * MAX_SPEED, STRUGGLE_ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, STRUGGLE_FRICTION * delta)
	move()

#SHORTCUT FUNCTIONS

func get_input():
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
func move():
	velocity = move_and_slide(velocity)
