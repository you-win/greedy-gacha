extends KinematicBody2D

signal killed

const GRAVITY: float = 175.0
const JUMP: float = 1500.0
const SLERP_AMOUNT: float = 0.5

var current_velocity: Vector2 = Vector2.ZERO
var input_velocity: Vector2 = Vector2.ZERO

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("primary_action"):
		current_velocity.y = -JUMP
	else:
		current_velocity.y = lerp(current_velocity.y, GRAVITY, 0.5)
	
	current_velocity *= delta * 100
	
	current_velocity = move_and_slide(current_velocity, Vector2.UP)
	
	if self.get_slide_count() > 0:
		emit_signal("killed")

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


