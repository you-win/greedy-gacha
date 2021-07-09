class_name BaseMinigame
extends Node2D

signal minigame_finished

const Coin: Resource = preload("res://entities/coin.tscn")

###############################################################################
# Builtin functions                                                           #
###############################################################################

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_minigame_time_over() -> void:
	MinigameManager.load_next_minigame()

###############################################################################
# Private functions                                                           #
###############################################################################

func _adjust_self_position_in_viewport() -> void:
	var parent_viewport = get_parent()
	if parent_viewport is Viewport:
		var viewport_size: Vector2 = (parent_viewport as Viewport).size
		self.position = viewport_size / 2
	else:
		GameManager.log_message("Unable to adjust position in viewport", true)

func _spawn_coin_at(pos: Vector2) -> void:
	var coin: Node2D = Coin.instance()
	coin.spawn_position = pos
	
	call_deferred("add_child", coin)

func _setup_timer(duration: float) -> void:
	var timer: Timer = Timer.new()
	timer.one_shot = true
	timer.autostart = true
	timer.wait_time = duration
	
	timer.connect("timeout", self, "_on_minigame_time_over")
	
	call_deferred("add_child", timer)

###############################################################################
# Public functions                                                            #
###############################################################################


