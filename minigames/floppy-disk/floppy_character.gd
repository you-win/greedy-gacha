extends KinematicBody2D

const GRAVITY: float = 100.0
const JUMP: float = 500.0
const SPEED: float = 250.0
const SLERP_AMOUNT: float = 0.5

var current_velocity: Vector2 = Vector2.ZERO
var input_velocity: Vector2 = Vector2.ZERO

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	input_velocity = Vector2(SPEED, GRAVITY)
	if Input.is_action_just_pressed("primary_action"):
		input_velocity.y = -JUMP
	
	input_velocity *= delta
	
	current_velocity = current_velocity.slerp(input_velocity, 0.5)
	
	current_velocity = move_and_slide(current_velocity, Vector2.UP)

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


