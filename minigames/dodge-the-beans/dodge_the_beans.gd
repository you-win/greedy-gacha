extends BaseMinigame

const Bean1: Resource = preload("res://minigames/dodge-the-beans/entities/bean1.tscn")

onready var player: Area2D = $Player

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	_adjust_self_position_in_viewport()
	_setup_timer(10.0)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	player.position = get_local_mouse_position()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


