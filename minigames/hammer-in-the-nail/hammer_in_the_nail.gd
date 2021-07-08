extends Node2D

onready var hammer: Node2D = $Hammer

var total_nails: int = 0
var total_nails_completed: int = 0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	var parent_viewport = get_parent()
	if parent_viewport is Viewport:
		var viewport_size: Vector2 = (parent_viewport as Viewport).size
		self.position = viewport_size / 2
	
	for c in $Nails.get_children():
		c.connect("hammered_in", self, "_on_hammered_in")
		total_nails += 1

func _process(delta: float) -> void:
	hammer.global_position = get_global_mouse_position()

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_hammered_in() -> void:
	total_nails_completed += 1
	
	if total_nails_completed == total_nails:
		# TODO change this
		GameManager.player_data.points += 1
		MinigameManager.load_next_minigame()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


