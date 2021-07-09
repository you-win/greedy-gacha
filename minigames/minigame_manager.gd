extends Node

signal minigame_completed(data)

const MINIGAMES: Dictionary = {
	"TEST_GAME": "res://minigames/hammer-in-the-nail/hammer_in_the_nail.tscn",
	"TEST_GAME2": "res://minigames/hammer-in-the-nail/hammer_in_the_nail.tscn"
}

# String
var possible_minigames: Array = []

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	generate_possible_minigames()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func minigame_complete(data: Dictionary) -> void:
	emit_signal("minigame_completed", data)
	# TODO remove
	GameManager.log_message(str(data))

func load_next_minigame(minigame_name: String = "") -> void:
	if minigame_name.empty():
		# No more minigames to play, go to gamble
		if possible_minigames.empty():
			GameManager.main.change_screen("res://gambling/gambling_hub_screen.tscn")
		else:
			# randi_range is inclusive
			var random_index: int = GameManager.rng.randi_range(0, possible_minigames.size() - 1)
			var minigame_path: String = possible_minigames[random_index]
			possible_minigames.remove(random_index)
			
			GameManager.main.change_screen(MINIGAMES[minigame_path])
	else:
		if not MINIGAMES.has(minigame_name):
			GameManager.log_message("%s not found" % minigame_name, true)
		
		GameManager.main.change_screen(MINIGAMES[minigame_name])

# TODO update for when we have an actual gameplay loop
func generate_possible_minigames() -> void:
	possible_minigames = MINIGAMES.keys().duplicate()
