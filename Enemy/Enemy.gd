extends KinematicBody2D

export var ACCELERATION = 200
export var MAX_SPEED = 50

enum {
	SEARCH,
	CHASE
}

var state = CHASE
var velocity = Vector2.ZERO

func _physics_process(delta):
	match state:
		SEARCH:
			pass
		CHASE:
			accelerate_towards_point(PlayerStats.player_location, delta)
			
	velocity = move_and_slide(velocity)
			

	
func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	pass
