extends Control

export var name_label_path: NodePath
export var points_label_path: NodePath
export var minigames_unlocked_label_path: NodePath

onready var name_label: Label = get_node(name_label_path)
onready var points_label: Label = get_node(points_label_path)
onready var minigames_unlocked_label: Label = get_node(minigames_unlocked_label_path)

onready var play_games: Button = $PlayGamesContainer/PlayGames

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	play_games.connect("pressed", self, "_on_play_games")
	
	name_label.text = GameManager.player_data["name"]
	points_label.text = str(GameManager.player_data["points"])
	minigames_unlocked_label.text = str(GameManager.player_data["minigames_unlocked"])

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_play_games() -> void:
	MinigameManager.generate_possible_minigames()
	MinigameManager.load_next_minigame()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


