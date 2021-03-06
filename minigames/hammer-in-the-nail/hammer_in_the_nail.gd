extends BaseMinigame

onready var hammer: Node2D = $Hammer

var total_nails: int = 0
var total_nails_completed: int = 0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	_adjust_self_position_in_viewport()
	_setup_timer(12.0)
	
	for c in $Nails.get_children():
		c.connect("hammered_in", self, "_on_hammered_in")
		total_nails += 1

func _process(delta: float) -> void:
	hammer.global_position = get_global_mouse_position()

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_hammered_in(pos: Vector2) -> void:
	total_nails_completed += 1
	
	_spawn_coin_at(pos)
	GameManager.player_data.coins += 1

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


